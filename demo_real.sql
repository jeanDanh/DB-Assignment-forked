-- TODO: create demonstrations for the presentation

-- Test Derived attribute: Driver_star
USE GRAB;

-- 1. Check the initial driver star rating for Driver 8 (Currently has Trip 1 and 4, both 5 stars -> Average: 5.00)
SELECT ACCOUNT_ID, DRIVER_STAR FROM DRIVER WHERE ACCOUNT_ID = 8;

-- 2. Test UPDATE Trigger: Change the rating of Trip 4 from 5 to 3
UPDATE COMPLETED_TRIP SET RATING_STARS = 3 WHERE TRIP_ID = 4;

-- Check star rating after update (Expected: (5 + 3) / 2 = 4.00)
SELECT ACCOUNT_ID, DRIVER_STAR FROM DRIVER WHERE ACCOUNT_ID = 8;

-- 3. Test DELETE Trigger: Remove the completed trip completely
DELETE FROM COMPLETED_TRIP WHERE TRIP_ID = 1;

-- Check star rating after deletion (Expected: 3.00, as only Trip 4 with 3 stars remains)
SELECT ACCOUNT_ID, DRIVER_STAR FROM DRIVER WHERE ACCOUNT_ID = 8;

-- 4. Test INSERT Trigger: Re-insert Trip 1 with a 1-star rating
INSERT INTO
    COMPLETED_TRIP (
        TRIP_ID,
        TO_TIME,
        OBTAINED_GRABCOIN,
        RATING_STARS,
        FEEDBACK,
        DRIVER_PAY
    )
VALUES (
        1,
        '2026-01-03 08:30:00',
        21,
        1,
        'Very bad ride',
        42000
    );

-- Check the driver star rating after insertion (Expected: (3 + 1) / 2 = 2.00)
SELECT ACCOUNT_ID, DRIVER_STAR FROM DRIVER WHERE ACCOUNT_ID = 8;




-- Test Function: GRAB_COIN_BONUS
-- Calculates end-of-month loyalty bonus coins for a passenger.


-- Test case 1: Passenger 3, April 2026.
-- Has one completed trip, paid cashless, with a 5-star rating.
-- Expected bonus: 5 (cashless) + 10 (rating) = 15.
SELECT GRAB_COIN_BONUS (3, 4, 2026) AS 'Passenger 3, Apr 2026 Bonus';

-- Test case 2: Passenger with no completed trips in the given month.
-- Expected: 0
SELECT GRAB_COIN_BONUS (1, 2, 2026) AS 'Passenger 1, Feb 2026 Bonus';