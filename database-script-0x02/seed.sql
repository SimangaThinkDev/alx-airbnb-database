-- ===== Generate UUIDs for 10 Users =====
SET @u1 := UUID();
SET @u2 := UUID();
SET @u3 := UUID();
SET @u4 := UUID();
SET @u5 := UUID();
SET @u6 := UUID();
SET @u7 := UUID();
SET @u8 := UUID();
SET @u9 := UUID();
SET @u10 := UUID();

-- ===== Insert Users =====
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(@u1, 'Alice', 'Smith', 'alice@example.com', 'hashedpwd1', '1234567890', 'guest'),
(@u2, 'Bob', 'Johnson', 'bob@example.com', 'hashedpwd2', '0987654321', 'host'),
(@u3, 'Carol', 'Williams', 'carol@example.com', 'hashedpwd3', '5551234567', 'guest'),
(@u4, 'David', 'Brown', 'david@example.com', 'hashedpwd4', '4449876543', 'admin'),
(@u5, 'Eve', 'Davis', 'eve@example.com', 'hashedpwd5', '3332221111', 'guest'),
(@u6, 'Frank', 'Miller', 'frank@example.com', 'hashedpwd6', '6665554444', 'host'),
(@u7, 'Grace', 'Wilson', 'grace@example.com', 'hashedpwd7', '7778889999', 'guest'),
(@u8, 'Hank', 'Moore', 'hank@example.com', 'hashedpwd8', '8889990000', 'guest'),
(@u9, 'Ivy', 'Taylor', 'ivy@example.com', 'hashedpwd9', '9990001111', 'host'),
(@u10, 'Jack', 'Anderson', 'jack@example.com', 'hashedpwd10', '0001112222', 'guest');

-- ===== Generate UUIDs for 6 Properties =====
SET @p1 := UUID();
SET @p2 := UUID();
SET @p3 := UUID();
SET @p4 := UUID();
SET @p5 := UUID();
SET @p6 := UUID();

-- ===== Insert Properties =====
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
(@p1, @u2, 'Cozy Cabin', 'A small wooden cabin in the forest', 'Cape Town', 1200.00),
(@p2, @u2, 'Modern Apartment', 'Spacious 2-bedroom apartment', 'Johannesburg', 950.50),
(@p3, @u2, 'Beach House', 'Oceanfront home with private beach', 'Durban', 2100.75),
(@p4, @u6, 'Mountain Retreat', 'Secluded mountain cabin', 'Drakensberg', 1800.00),
(@p5, @u9, 'City Loft', 'Stylish loft in city center', 'Pretoria', 1300.00),
(@p6, @u9, 'Country Farmhouse', 'Charming farmhouse with garden', 'Stellenbosch', 1100.00);

-- ===== Generate UUIDs for 8 Bookings =====
SET @b1 := UUID();
SET @b2 := UUID();
SET @b3 := UUID();
SET @b4 := UUID();
SET @b5 := UUID();
SET @b6 := UUID();
SET @b7 := UUID();
SET @b8 := UUID();

-- ===== Insert Bookings =====
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(@b1, @p1, @u1, '2025-07-10', '2025-07-12', 2400.00, 'confirmed'),
(@b2, @p2, @u3, '2025-07-15', '2025-07-18', 2851.50, 'pending'),
(@b3, @p1, @u3, '2025-07-20', '2025-07-22', 2400.00, 'confirmed'),
(@b4, @p4, @u5, '2025-08-01', '2025-08-05', 7200.00, 'confirmed'),
(@b5, @p5, @u7, '2025-08-10', '2025-08-12', 2600.00, 'canceled'),
(@b6, @p6, @u8, '2025-08-15', '2025-08-18', 3300.00, 'confirmed'),
(@b7, @p3, @u10, '2025-08-20', '2025-08-23', 6302.25, 'pending'),
(@b8, @p2, @u1, '2025-08-25', '2025-08-27', 1901.00, 'confirmed');

-- ===== Generate UUIDs for 5 Payments =====
SET @pay1 := UUID();
SET @pay2 := UUID();
SET @pay3 := UUID();
SET @pay4 := UUID();
SET @pay5 := UUID();

-- ===== Insert Payments =====
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
(@pay1, @b1, 2400.00, 'credit_card'),
(@pay2, @b3, 2400.00, 'paypal'),
(@pay3, @b4, 7200.00, 'stripe'),
(@pay4, @b6, 3300.00, 'credit_card'),
(@pay5, @b8, 1901.00, 'paypal');

-- ===== Generate UUIDs for 6 Reviews =====
SET @r1 := UUID();
SET @r2 := UUID();
SET @r3 := UUID();
SET @r4 := UUID();
SET @r5 := UUID();
SET @r6 := UUID();

-- ===== Insert Reviews =====
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
(@r1, @p1, @u1, 5, 'Absolutely loved it! Very peaceful.'),
(@r2, @p1, @u3, 4, 'Cozy and clean, but a bit cold at night.'),
(@r3, @p2, @u3, 3, 'Nice place, but had some noise.'),
(@r4, @p4, @u5, 5, 'Perfect getaway in the mountains.'),
(@r5, @p6, @u8, 4, 'Lovely farmhouse with a great garden.'),
(@r6, @p5, @u7, 2, 'City loft was noisy but convenient.');

-- ===== Generate UUIDs for 6 Messages =====
SET @m1 := UUID();
SET @m2 := UUID();
SET @m3 := UUID();
SET @m4 := UUID();
SET @m5 := UUID();
SET @m6 := UUID();

-- ===== Insert Messages =====
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
(@m1, @u1, @u2, 'Hi, is the cabin available next weekend?'),
(@m2, @u2, @u1, 'Yes, it’s available! Let me know if you want to book.'),
(@m3, @u3, @u2, 'Thanks for hosting us! We had a great time.'),
(@m4, @u5, @u6, 'Can I book the mountain retreat for early August?'),
(@m5, @u6, @u5, 'Yes, it’s free then. Looking forward to hosting you!'),
(@m6, @u7, @u9, 'Is the city loft pet friendly?');
