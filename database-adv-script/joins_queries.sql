-- Write a query using an INNER JOIN to retrieve all 
-- bookings and the respective users who made those 
-- bookings.

SELECT b.start_date, b.end_date, b.status, u.first_name, u.last_name, u.role 
FROM Booking b
JOIN User u
ON u.user_id = b.user_id
WHERE u.role = 'guest';

-- Write a query using aLEFT JOIN to retrieve all 
-- properties and their reviews, including 
-- properties that have no reviews.

SELECT p.name, p.description, p.location, r.rating, r.comment
FROM Property
LEFT OUTER JOIN Review r
ON p.property_id = r.property_id;

-- Write a query using a FULL OUTER JOIN to retrieve
-- all users and all bookings, even if the user has
-- no booking or a booking is not linked to a user.

SELECT u.first_name, u.last_name, u.role, b.start_date, b.end_date, b.total_price, b.status
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id
UNION
SELECT u.first_name, u.last_name, u.role, b.start_date, b.end_date, b.total_price, b.status
FROM User u
RIGHT JOIN Booking b ON u.user_id = b.user_id;