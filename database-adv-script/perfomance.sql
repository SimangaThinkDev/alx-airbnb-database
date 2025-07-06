-- Add an index to Booking.user_id if not already present or implicitly created by FK
-- (Run this DDL statement if you find it missing after EXPLAIN)
-- CREATE INDEX idx_user_id_booking ON Booking (user_id);

-- Refactored query for improved performance
SELECT
  B.booking_id,
  B.start_date,
  B.end_date,
  B.total_price AS booking_total_price,
  B.status AS booking_status,
  U.user_id,
  U.first_name,
  U.last_name,
  U.email,
  P.property_id,
  P.name AS property_name,
  P.location AS property_location,
  P.pricepernight,
  Py.payment_id,
  Py.amount AS payment_amount,
  Py.payment_date,
  Py.payment_method
FROM Booking AS B
JOIN User AS U
  ON B.user_id = U.user_id
JOIN Property AS P
  ON B.property_id = P.property_id
LEFT JOIN Payment AS Py
  ON B.booking_id = Py.booking_id;

