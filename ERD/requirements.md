## Database Design

### 1. User
Represents people using the platform (guests and hosts).

Important Fields:

- id: Unique identifier
- name: Full name
- email: Unique user email
- password_hash: Securely stored password
- is_host: Boolean flag indicating if user is a host

Relationships:

- A user can create multiple properties (if they are a host).
- A user can make multiple bookings (as a guest).
- A user can write multiple reviews.

### 2. Property

Represents a listing (home, apartment, room, etc.) available for booking.

Important Fields:
- id: Unique identifier
- title: Name or headline of the property
- description: Detailed description
- location: Address or coordinates
- price_per_night: Cost to book for one night

Relationships:

- A property belongs to one user (host).
- A property can have many bookings.
- A property can have many reviews.

### 3. Booking

Represents a reservation made by a user for a specific property.

Important Fields:

- id: Unique identifier
- user_id: ID of the guest who made the booking
- property_id: ID of the booked property
- start_date: Booking start date
- end_date: Booking end date

Relationships:

- A booking belongs to one user.
- A booking belongs to one property.
- A booking may have one payment record.

### 4. Review

Represents feedback given by a user after a stay.

Important Fields:

- id: Unique identifier
- user_id: Author of the review
- property_id: Reviewed property
- rating: Numerical score (e.g., 1–5)
- comment: Written feedback

Relationships:

- A review belongs to one user.
- A review belongs to one property.

### 5. Payment

Represents the transaction for a booking.

Important Fields:

- id: Unique identifier
- booking_id: Associated booking
- amount: Total amount paid
- payment_method: (e.g., credit card, PayPal)
- status: (e.g., pending, completed, failed)

Relationships:

- A payment belongs to one booking.