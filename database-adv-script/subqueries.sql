-- Write a query to find all properties where the average 
-- rating is greater than 4.0 using a subquery.

SELECT * 
FROM Property
WHERE property_id IN (
    SELECT property_id
    FROM Review
    WHERE rating > 4
);

-- Write a correlated subquery to find users who have 
-- made more than 3 bookings.

SELECT u.first_name, u.last_name
FROM User u
WHERE u.user_id IN (
    SELECT b.user_id
    FROM Booking b
    GROUP BY b.user_id
    HAVING COUNT(b.booking_id) > 3 -- Count bookings per user and filter
);
