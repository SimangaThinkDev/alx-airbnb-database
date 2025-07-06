-- Write a query to find the total number of bookings
-- made by each user, using the COUNT function and
-- GROUP BY clause.

SELECT 
    user_id,
    COUNT(*) AS total_bookings
FROM 
    Booking
GROUP BY 
    user_id;

-- Use a window function (ROW_NUMBER, RANK) to rank
-- properties based on the total number of bookings
-- they have received.

-- Property ranking using ROW_NUMBER()
SELECT 
    property_id,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM (
    SELECT 
        property_id,
        COUNT(*) AS total_bookings
    FROM 
        Booking
    GROUP BY 
        property_id
) AS booking_counts;

-- Property ranking using RANK()
SELECT 
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT 
        property_id,
        COUNT(*) AS total_bookings
    FROM 
        Booking
    GROUP BY 
        property_id
) AS booking_counts;


