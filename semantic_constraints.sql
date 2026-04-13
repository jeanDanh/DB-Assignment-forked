USE GRAB;

DELIMITER //

-- constraint 9

CREATE TRIGGER TRIP_STATUS_ORDER
BEFORE UPDATE ON TRIP
FOR EACH ROW
BEGIN
    DECLARE old_status ENUM(
        'PENDING',
        'ASSIGNED',
        'DRIVER_ARRIVED',
        'ONGOING',
        'COMPLETED',
        'CANCELLED'
    );

    DECLARE is_valid BOOL;

    SET old_status = OLD.STATUS;
    SET is_valid = TRUE;

    CASE
        WHEN old_status = 'PENDING' THEN
            IF NEW.STATUS <> 'ASSIGNED' AND NEW.STATUS <> 'CANCELLED' THEN
                SET is_valid = FALSE;
            END IF;
        WHEN old_status = 'ASSIGNED' THEN
            IF NEW.STATUS <> 'DRIVER_ARRIVED' THEN
                SET is_valid = FALSE;
            END IF;
        WHEN old_status = 'DRIVER_ARRIVED' THEN
            IF NEW.STATUS <> 'ONGOING' THEN
                SET is_valid = FALSE;
            END IF;
        WHEN old_status = 'ONGOING' THEN
            IF NEW.STATUS <> 'COMPLETED' THEN
                SET is_valid = FALSE;
            END IF;
        WHEN old_status = 'COMPLETED' THEN
            -- prevent changing to anything other than completed
            IF NEW.STATUS <> 'COMPLETED' THEN
                SET is_valid = FALSE;
            END IF;
        ELSE
            IF NEW.STATUS <> 'CANCELLED' THEN
                SET is_valid = FALSE;
            END IF;
    END CASE;

    IF is_valid = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Semantic constraint violated: Trip status is out of order';
    END IF;
END//


-- Sets the grab coin automatically
CREATE TRIGGER GRABCOIN_ACCUMULATION
AFTER INSERT ON COMPLETED_TRIP
FOR EACH ROW 
BEGIN
    DECLARE trip_final_price INT;
    DECLARE T_ID INT;
    SET T_ID = NEW.TRIP_ID;
    SELECT FINAL_PRICE INTO trip_final_price FROM TRIP WHERE TRIP.TRIP_ID = T_ID;

    SET trip_final_price = final_price DIV 2000;

    UPDATE COMPLETED_TRIP
    SET OBTAINED_GRABCOIN = trip_final_price
    WHERE TRIP_ID = T_ID;
    
END//
DELIMITER;