CREATE TYPE role_enum AS ENUM ( 'guest', 'host', 'admin' ); 

CREATE TABLE User (
    user_id UUID PRIMARY KEY, -- What if the UUID will be generated in the queries themselves? or should we keep the gen_random_UUID() method in this line
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL, -- I want better constraints on this
    role role_enum NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID REFERENCES User(user_id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TYPE status_enum AS ENUM ('pending', 'confirmed', 'canceled');

CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID REFERENCES Property(property_id),
    user_id UUID REFERENCES "User"(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status status_enum NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');

CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID REFERENCES Booking(booking_id),
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_enum
);



CREATE TABLE Review (
    review_id PRIMARY KEY UUID,
    property_id UUID REFERENCES Property(property_id),
);