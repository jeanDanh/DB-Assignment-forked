-- This file is used for procedures/ triggers/ functions... testing.
-- Note that some may produce errors for demonstration. You would like to run only the part you want to test.

USE GRAB;

-- Test procedure 1
--  Xem xe của Tài xế 8
CALL GET_DRIVER_VEHICLE_LIST(8, NULL, NULL, 'CAPACITY_DESC');

--  Lọc riêng xe máy của Tài xế 8, xếp theo tên hãng (Make) A-Z
CALL GET_DRIVER_VEHICLE_LIST(8, 'Bike', NULL, 'MAKE');

--  Lọc car của Tài xế 8, capacity >= 4
CALL GET_DRIVER_VEHICLE_LIST(8, 'Car', 4, 'CAPACITY_ASC');

-- Test procedure 2
-- 6 months
CALL GET_MONTHLY_COMPLETED_TRIPS_REPORT(6);
-- 1 month
CALL GET_MONTHLY_COMPLETED_TRIPS_REPORT(1);

-- Test function 1: GRAB_COIN_BONUS
-- Calculates end-of-month loyalty bonus coins for a passenger.

-- Test case 1: Passenger 1, January 2026.
-- Has one completed trip during rush hour (8 AM) with a 5-star rating.
-- Expected bonus: (14 base coins * 0.5 for rush hour) + 10 for 5-star rating = 7 + 10 = 17.
SELECT GRAB_COIN_BONUS(1, 1, 2026) AS 'Passenger 1, Jan 2026 Bonus';

-- Test case 2: Passenger 3, April 2026.
-- Has one completed trip, paid cashless, with a 5-star rating.
-- Expected bonus: 5 (cashless) + 10 (rating) = 15.
SELECT GRAB_COIN_BONUS(3, 4, 2026) AS 'Passenger 3, Apr 2026 Bonus';

-- Test case 3: Passenger with no completed trips in the given month.
-- Expected: 0
SELECT GRAB_COIN_BONUS(1, 2, 2026) AS 'Passenger 1, Feb 2026 Bonus (No Trips)';

-- Test case 4: Invalid passenger ID (should produce an error). Uncomment to test.
-- SELECT GRAB_COIN_BONUS(99, 1, 2026);

-- Test case 5: Invalid month (should produce an error). Uncomment to test.
-- SELECT GRAB_COIN_BONUS(1, 13, 2026);