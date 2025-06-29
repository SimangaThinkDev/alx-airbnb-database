-- Insert Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  (gen_random_uuid(), 'Thandeka', 'Dlamini', 'thandeka.dlamini@example.co.za', 'hashed_pw_1', '+27831234567', 'guest'),
  (gen_random_uuid(), 'Sipho', 'Ndlovu', 'sipho.ndlovu@example.co.za', 'hashed_pw_2', '+27837654321', 'host'),
  (gen_random_uuid(), 'Zola', 'Khumalo', 'zola.khumalo.admin@example.co.za', 'hashed_pw_3', '+27839876543', 'admin');


-- Insert Properties (hosted by Sipho)
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES 
  (gen_random_uuid(), 
   (SELECT user_id FROM "User" WHERE email = 'sipho.ndlovu@example.co.za'), 
   'Serene Sunnyside Apartment',
   'A spacious apartment with city views in Pretoria.',
   'Pretoria, South Africa',
   1500.00);


-- Insert Booking (Thandeka books Sipho's property)
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES 
  (gen_random_uuid(),
   (SELECT property_id FROM Property LIMIT 1),
   (SELECT user_id FROM "User" WHERE email = 'thandeka.dlamini@example.co.za'),
   '2025-07-10',
   '2025-07-15',
   7500.00,
   'confirmed');


-- Insert Payment (Thandeka pays for booking)
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES 
  (gen_random_uuid(),
   (SELECT booking_id FROM Booking LIMIT 1),
   7500.00,
   'EFT');


-- Insert Review (Thandeka leaves a review)
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES 
  (gen_random_uuid(),
   (SELECT property_id FROM Property LIMIT 1),
   (SELECT user_id FROM "User" WHERE email = 'thandeka.dlamini@example.co.za'),
   4,
   'Lovely place, very convenient location!');


-- Insert Message (Thandeka sends a message to Sipho)
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES 
  (gen_random_uuid(),
   (SELECT user_id FROM "User" WHERE email = 'thandeka.dlamini@example.co.za'),
   (SELECT user_id FROM "User" WHERE email = 'sipho.ndlovu@example.co.za'),
   'Hi Sipho, just confirming the check-in time. Thanks!');

   