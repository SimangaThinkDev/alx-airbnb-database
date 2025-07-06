
-- Indexes on Booking table
CREATE INDEX idx_booking_user_property ON Booking (user_id, property_id);
CREATE INDEX idx_booking_status ON Booking (status);
CREATE INDEX idx_booking_start_date ON Booking (start_date);

-- Indexes on Property table
CREATE INDEX idx_property_host_id ON Property (host_id);
CREATE INDEX idx_property_location ON Property (location);

-- Index on User table
CREATE INDEX idx_user_role ON User (role);

-- Check perfomance
EXPLAIN ANALYZE
SELECT *
FROM Booking
WHERE user_id = 'some-user-id' AND property_id = 'some-prop-id';

