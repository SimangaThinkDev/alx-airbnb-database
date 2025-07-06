-- MySQL Insert Statements

-- Insert Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  (UUID(), 'Thandeka', 'Dlamini', 'thandeka.dlamini@example.co.za', 'hashed_pw_1', '+27831234567', 'guest'),
  (UUID(), 'Sipho', 'Ndlovu', 'sipho.ndlovu@example.co.za', 'hashed_pw_2', '+27837654321', 'host'),
  (UUID(), 'Zola', 'Khumalo', 'zola.khumalo.admin@example.co.za', 'hashed_pw_3', '+27839876543', 'admin');


-- Insert Properties (hosted by Sipho)
-- Note: Subqueries for host_id will work correctly in MySQL
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
  (UUID(),
   (SELECT user_id FROM User WHERE email = 'sipho.ndlovu@example.co.za'),
   'Serene Sunnyside Apartment',
   'A spacious apartment with city views in Pretoria.',
   'Pretoria, South Africa',
   1500.00);


-- Insert Booking (Thandeka books Sipho's property)
-- Note: Subqueries for property_id and user_id will work correctly in MySQL
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  (UUID(),
   (SELECT property_id FROM Property LIMIT 1), -- Assuming only one property exists for simplicity
   (SELECT user_id FROM User WHERE email = 'thandeka.dlamini@example.co.za'),
   '2025-07-10',
   '2025-07-15',
   7500.00,
   'confirmed');


-- Insert Payment (Thandeka pays for booking)
-- Changed 'EFT' to 'credit_card' to match the ENUM definition in the MySQL schema
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
  (UUID(),
   (SELECT booking_id FROM Booking LIMIT 1), -- Assuming only one booking exists for simplicity
   7500.00,
   'credit_card');


-- Insert Review (Thandeka leaves a review)
-- Note: Subqueries for property_id and user_id will work correctly in MySQL
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
  (UUID(),
   (SELECT property_id FROM Property LIMIT 1), -- Assuming only one property exists for simplicity
   (SELECT user_id FROM User WHERE email = 'thandeka.dlamini@example.co.za'),
   4,
   'Lovely place, very convenient location!');


-- Insert Message (Thandeka sends a message to Sipho)
-- Note: Subqueries for sender_id and recipient_id will work correctly in MySQL
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
  (UUID(),
   (SELECT user_id FROM User WHERE email = 'thandeka.dlamini@example.co.za'),
   (SELECT user_id FROM User WHERE email = 'sipho.ndlovu@example.co.za'),
   'Hi Sipho, just confirming the check-in time. Thanks!');