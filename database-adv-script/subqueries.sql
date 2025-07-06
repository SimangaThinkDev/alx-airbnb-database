-- Write a query to find all properties where the average 
-- rating is greater than 4.0 using a subquery.

SELECT p.name, p.description, p.location
FROM Property p
WHERE p.property_id IN (
    SELECT property_id
    FROM Review
    GROUP BY property_id -- Group reviews by property
    HAVING AVG(rating) > 4.0 -- Filter groups where the average rating is > 4.0
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

