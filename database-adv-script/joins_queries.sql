
-- Write a query using an INNER JOIN to retrieve all 
-- bookings and the respective users who made those 
-- bookings.

SELECT b.start_date, b.end_date, b.status, u.first_name, u.last_name, u.role 
FROM Booking b
JOIN User u
ON u.user_id = b.user_id
WHERE u.role = 'guest';

