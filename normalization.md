# Database Normalization: From 1NF to 3NF

## Objective:
To apply normalization principles to ensure the database design is in the Third Normal Form (3NF), thereby reducing data redundancy and improving data integrity.

## Initial Database Schema (Assumed to be in 1NF):

The provided database schema consists of the following entities and their attributes:

**User Table**
* `user_id`: Primary Key, UUID, Indexed
* `first_name`: VARCHAR, NOT NULL
* `last_name`: VARCHAR, NOT NULL
* `email`: VARCHAR, UNIQUE, NOT NULL
* `password_hash`: VARCHAR, NOT NULL
* `phone_number`: VARCHAR, NULL
* `role`: ENUM (guest, host, admin), NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Property Table**
* `property_id`: Primary Key, UUID, Indexed
* `host_id`: Foreign Key, references User(user_id)
* `name`: VARCHAR, NOT NULL
* `description`: TEXT, NOT NULL
* `location`: VARCHAR, NOT NULL
* `pricepernight`: DECIMAL, NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* `updated_at`: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

**Booking Table**
* `booking_id`: Primary Key, UUID, Indexed
* `property_id`: Foreign Key, references Property(property_id)
* `user_id`: Foreign Key, references User(user_id)
* `start_date`: DATE, NOT NULL
* `end_date`: DATE, NOT NULL
* `total_price`: DECIMAL, NOT NULL
* `status`: ENUM (pending, confirmed, canceled), NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Payment Table**
* `payment_id`: Primary Key, UUID, Indexed
* `booking_id`: Foreign Key, references Booking(booking_id)
* `amount`: DECIMAL, NOT NULL
* `payment_date`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* `payment_method`: ENUM (credit_card, paypal, stripe), NOT NULL

**Review Table**
* `review_id`: Primary Key, UUID, Indexed
* `property_id`: Foreign Key, references Property(property_id)
* `user_id`: Foreign Key, references User(user_id)
* `rating`: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
* `comment`: TEXT, NOT NULL
* `created_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

**Message Table**
* `message_id`: Primary Key, UUID, Indexed
* `sender_id`: Foreign Key, references User(user_id)
* `recipient_id`: Foreign Key, references User(user_id)
* `message_body`: TEXT, NOT NULL
* `sent_at`: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Normalization Steps and Explanation:

### Step 1: Achieving First Normal Form (1NF)

**Definition:** A relation is in 1NF if every attribute in a tuple is atomic (indivisible) and there are no repeating groups of attributes.

**Analysis of Initial Schema:**
The initial database schema already satisfies 1NF.
* **Atomic Attributes:** Each attribute (e.g., `first_name`, `email`, `pricepernight`, `start_date`) holds a single, indivisible value. There are no multi-valued attributes or lists stored within a single field.
* **No Repeating Groups:** There are no sets of columns that repeat within the same table (e.g., `phone_number1`, `phone_number2`). Related information is structured into separate tables (e.g., `User` for user details, `Property` for property details).
* **Unique Rows:** Each table has a designated primary key (`user_id`, `property_id`, `booking_id`, `payment_id`, `review_id`, `message_id`) that ensures every row is uniquely identifiable.

**Conclusion for 1NF:** The provided database design is already in 1NF. No adjustments are needed at this stage.

### Step 2: Achieving Second Normal Form (2NF)

**Definition:** A relation is in 2NF if it is in 1NF and all non-key attributes are fully functionally dependent on the primary key. This primarily addresses tables with composite primary keys, ensuring no non-key attribute depends on only a *part* of the composite key.

**Analysis of Initial Schema:**
Upon examining the tables, none of the primary keys are composite. Each table uses a single attribute (`UUID`) as its primary key.
* `User`: Primary Key is `user_id`.
* `Property`: Primary Key is `property_id`.
* `Booking`: Primary Key is `booking_id`.
* `Payment`: Primary Key is `payment_id`.
* `Review`: Primary Key is `review_id`.
* `Message`: Primary Key is `message_id`.

Since there are no composite primary keys, there are no partial dependencies to resolve. All non-key attributes in each table are fully dependent on their respective single-column primary key.

**Conclusion for 2NF:** The provided database design is already in 2NF. No adjustments are needed at this stage.

### Step 3: Achieving Third Normal Form (3NF)

**Definition:** A relation is in 3NF if it is in 2NF and there are no transitive dependencies. A transitive dependency exists when a non-key attribute is dependent on another non-key attribute. In simpler terms, "nothing but the key, the whole key, and nothing but the key."

**Analysis of Initial Schema:**
We meticulously reviewed each table for transitive dependencies:

* **User Table:** All attributes (`first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`) directly describe the `user_id`. There are no non-key attributes that depend on another non-key attribute.
* **Property Table:** All attributes (`host_id`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`) directly describe the `property_id`. The `host_id` is a foreign key, but it directly relates to the property's ownership, not a description of another non-key attribute within the `Property` table.
* **Booking Table:** All attributes (`property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`) directly describe the `booking_id`. `property_id` and `user_id` are foreign keys that establish relationships, but they are not transitively dependent on other non-key attributes within the `Booking` table. `total_price` is calculated based on `start_date`, `end_date`, and `pricepernight` from the `Property` table, but it's an attribute of the *booking itself*, not a derived attribute that would cause a transitive dependency *within the `Booking` table*.
* **Payment Table:** All attributes (`booking_id`, `amount`, `payment_date`, `payment_method`) directly describe the `payment_id`. `booking_id` is a foreign key.
* **Review Table:** All attributes (`property_id`, `user_id`, `rating`, `comment`, `created_at`) directly describe the `review_id`. `property_id` and `user_id` are foreign keys.
* **Message Table:** All attributes (`sender_id`, `recipient_id`, `message_body`, `sent_at`) directly describe the `message_id`. `sender_id` and `recipient_id` are foreign keys.

No transitive dependencies were identified in any of the tables. The design effectively separates concerns, ensuring that each non-key attribute is directly dependent on the primary key of its respective table and not on another non-key attribute.

**Conclusion for 3NF:** The provided database design is already in 3NF. No adjustments are needed at this stage.

## Final Database Schema (Already in 3NF):

The database schema, as initially provided, is robust and already meets the criteria for Third Normal Form.

**User**
* `user_id` (PK)
* `first_name`
* `last_name`
* `email` (UNIQUE)
* `password_hash`
* `phone_number`
* `role`
* `created_at`

**Property**
* `property_id` (PK)
* `host_id` (FK to User)
* `name`
* `description`
* `location`
* `pricepernight`
* `created_at`
* `updated_at`

**Booking**
* `booking_id` (PK)
* `property_id` (FK to Property)
* `user_id` (FK to User)
* `start_date`
* `end_date`
* `total_price`
* `status`
* `created_at`

**Payment**
* `payment_id` (PK)
* `booking_id` (FK to Booking)
* `amount`
* `payment_date`
* `payment_method`

**Review**
* `review_id` (PK)
* `property_id` (FK to Property)
* `user_id` (FK to User)
* `rating`
* `comment`
* `created_at`

**Message**
* `message_id` (PK)
* `sender_id` (FK to User)
* `recipient_id` (FK to User)
* `message_body`
* `sent_at`

## Summary:

The provided database schema is well-designed and inherently adheres to the principles of 1NF, 2NF, and 3NF. No modifications were required to achieve 3NF as the initial design correctly minimized redundancy and ensured proper functional dependencies from the outset. This design promotes data integrity, consistency, and efficient data management.
 git 