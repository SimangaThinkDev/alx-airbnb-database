-- Table for Users
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY, -- UUIDs are typically stored as CHAR(36) in MySQL
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    -- ENUM type defined directly within the table for MySQL
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for Properties
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY, -- UUIDs as CHAR(36)
    host_id CHAR(36), -- Foreign key to User table
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL, -- Added precision and scale for DECIMAL
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- MySQL specific: ON UPDATE CURRENT_TIMESTAMP for automatic update on row modification
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for Bookings
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY, -- UUIDs as CHAR(36)
    property_id CHAR(36), -- Foreign key to Property table
    user_id CHAR(36), -- Foreign key to User table
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL, -- Added precision and scale for DECIMAL
    -- ENUM type defined directly within the table for MySQL
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- CHECK constraint (enforced in MySQL 8.0.16+)
    CONSTRAINT chk_end_date_after_start_date CHECK (end_date > start_date),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for Payments
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY, -- UUIDs as CHAR(36)
    booking_id CHAR(36), -- Foreign key to Booking table
    amount DECIMAL(10, 2) NOT NULL, -- Added precision and scale for DECIMAL
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- ENUM type defined directly within the table for MySQL
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for Reviews
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY, -- UUIDs as CHAR(36)
    property_id CHAR(36), -- Foreign key to Property table
    user_id CHAR(36), -- Foreign key to User table
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- CHECK constraint for rating (enforced in MySQL 8.0.16+)
    CONSTRAINT chk_rating_range CHECK (rating >= 1 AND rating <= 5),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table for Messages
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY, -- UUIDs as CHAR(36)
    sender_id CHAR(36), -- Foreign key to User table (sender)
    recipient_id CHAR(36), -- Foreign key to User table (recipient)
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes
CREATE INDEX idx_email ON User (email);
CREATE INDEX idx_property_id_property ON Property (property_id); -- Redundant as it's a PK, but kept for consistency with original request
CREATE INDEX idx_property_id_booking ON Booking (property_id);
CREATE INDEX idx_booking_id_booking ON Booking (booking_id); -- Redundant as it's a PK, but kept for consistency with original request
CREATE INDEX idx_booking_id_payment ON Payment (booking_id);