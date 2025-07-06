# Optimization Report

### 1. Initial query to retrieve all bookings with user, property, and payment details

```sql
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
```

### 2. Analysis on initial query

```sql
EXPLAIN
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
```

### 3. Refactored query for Perfomance

```sql
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
```

Also found [here](./perfomance.sql)

## Summary

    The performance.sql file initially contained a complex SQL query designed to retrieve all booking details along with associated user, property, and payment information by joining multiple tables. To optimize this query, the first step involved using the EXPLAIN command to analyze its execution plan and identify performance bottlenecks, such as potential full table scans or inefficient join operations. The primary refactoring action proposed was to ensure proper indexing on foreign key columns, specifically recommending the addition of an index on Booking.user_id if it wasn't already implicitly created by MySQL's foreign key constraints. This indexing helps the database quickly locate matching rows during joins, significantly reducing query execution time without altering the necessary joins or selected data.