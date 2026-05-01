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




-- Test Procedure: GET_PASSENGER_MONTHLY_REPORT
-- Assuming current date is May 5, 2026.
-- The procedure calculates the cut-off date by subtracting months from LAST_DAY(CURRENT_DATE) (May 31, 2026).

-- ---------------------------------------------------------
-- TEST CASE 1: Passenger 1 (Activity in Jan and Mar 2026)
-- Passenger 1 has completed trips on 2026-01-03, 2026-03-01, and 2026-03-10.
-- ---------------------------------------------------------
SELECT '--- TEST 1: Passenger 1 (4-month lookback) ---' AS Scenario;

-- Looking back 4 months from May 31 gives a cut-off of Jan 31.
-- Expected: Returns ONLY the March trips. The Jan 3 trip is filtered out.
CALL GET_PASSENGER_MONTHLY_REPORT (1, 4);

-- ---------------------------------------------------------
-- TEST CASE 2: Passenger 2 (Single trip in Feb 2026)
-- Passenger 2 has one completed trip on 2026-02-20.
-- ---------------------------------------------------------
SELECT '--- TEST 2: Passenger 2 (Short-range vs Long-range) ---' AS Scenario;

-- Looking back 1 month from May 31 gives a cut-off of April 30.
SELECT 'Results for 1-month lookback (Expected: Empty):' AS Sub_Test;
CALL GET_PASSENGER_MONTHLY_REPORT (2, 1);

-- Looking back 4 months from May 31 gives a cut-off of Jan 31.
SELECT 'Results for 4-month lookback (Expected: 1 trip in Feb):' AS Sub_Test;
CALL GET_PASSENGER_MONTHLY_REPORT (2, 4);



-- Test Function: GRAB_COIN_BONUS
-- Calculates end-of-month loyalty bonus coins for a passenger.


-- Test case 1: Passenger 3, April 2026.
-- Has one completed trip, paid cashless, with a 5-star rating.
-- Expected bonus: 5 (cashless) + 10 (rating) = 15.
SELECT GRAB_COIN_BONUS (3, 4, 2026) AS 'Passenger 3, Apr 2026 Bonus';

-- Test case 2: Passenger with no completed trips in the given month.
-- Expected: 0
SELECT GRAB_COIN_BONUS (1, 2, 2026) AS 'Passenger 1, Feb 2026 Bonus';







-- Test Function: CALCULATE_DRIVER_BONUS_FEE
-- Calculates a monthly bonus for drivers based on completed trips.

-- Test case 1: Driver 6, March 2026.
-- Has two completed trips (Trip 6, Trip 7) with payment.
-- Both have 5-star ratings (+2000 each) and vehicle capacity < 6. Base bonus (+5000 each).
-- Expected bonus: (5000 + 2000) * 2 = 14000.
SELECT CALCULATE_DRIVER_BONUS_FEE (6, 3, 2026) AS 'Driver 6, Mar 2026 Bonus';

-- Test case 2: Driver 8, February 2026.
-- Has one completed trip (Trip 4). 
-- Its rating was updated to 3 stars earlier in this file (+0). Vehicle capacity >= 6 (+1500). Base bonus (+5000).
-- Expected bonus: 5000 + 0 + 1500 = 6500.
SELECT CALCULATE_DRIVER_BONUS_FEE (8, 2, 2026) AS 'Driver 8, Feb 2026 Bonus';

-- Test case 3: Driver 8, January 2026.
-- Has one completed trip (Trip 1). But its payment transaction was deleted earlier (due to CASCADE DELETE).
-- Re-inserted trip doesn't have a payment transaction.
-- Expected bonus: 0.
SELECT CALCULATE_DRIVER_BONUS_FEE (8, 1, 2026) AS 'Driver 8, Jan 2026 Bonus (No Payment)';

-- Test case 4: Driver 10, January 2026.
-- No completed trips in this month.
-- Expected bonus: 0.
SELECT CALCULATE_DRIVER_BONUS_FEE (10, 1, 2026) AS 'Driver 10, Jan 2026 Bonus (No Trips)';