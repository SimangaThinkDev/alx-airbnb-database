# SQL Joins Explained
    This SQL file demonstrates different types of SQL joins used to combine data from multiple tables. Each query is designed to retrieve specific information based on the relationships between the User, Booking, Property, and Review tables.

### 1. INNER JOIN
Query Purpose: To retrieve all bookings and the details of the users who made those bookings, specifically filtering for users with the role 'guest'.

#### Approach Used:
An INNER JOIN (or simply JOIN) is used here. This type of join returns only the rows that have matching values in both tables based on the specified join condition (u.user_id = b.user_id). If a user has no bookings, or a booking has no matching user, those rows are excluded from the result set. The WHERE clause further refines the results to only include bookings made by users whose role is 'guest'.

### 2. LEFT JOIN (or LEFT OUTER JOIN)
Query Purpose: To retrieve all properties and any associated reviews, including properties that do not have any reviews yet.

#### Approach Used:
A LEFT JOIN (also known as LEFT OUTER JOIN) is employed. This join returns all rows from the left table (Property in this case), and the matching rows from the right table (Review). If there is no match in the right table for a row in the left table, the columns from the right table will contain NULL values. This ensures that all properties are listed, regardless of whether they have reviews.

### 3. FULL OUTER JOIN (Simulated in MySQL)
Query Purpose: To retrieve all users and all bookings. This includes users who have no bookings, and bookings that might not be linked to any user (though the latter is less common with proper foreign key constraints).

#### Approach Used:
MySQL does not directly support the FULL OUTER JOIN syntax. Therefore, this query simulates a FULL OUTER JOIN by combining a LEFT JOIN and a RIGHT JOIN using the UNION operator.

LEFT JOIN Part: Retrieves all users and their corresponding bookings. If a user has no bookings, the booking-related fields will be NULL.

RIGHT JOIN Part: Retrieves all bookings and their corresponding users. If a booking has no user (e.g., due to data inconsistency), the user-related fields will be NULL.

UNION Operator: Combines the results of the LEFT JOIN and RIGHT JOIN. The UNION operator automatically removes duplicate rows, ensuring that rows that match in both parts (i.e., users with bookings) are only listed once. This effectively provides a comprehensive list of all records from both tables, showing matches where they exist and NULL where they do not.


<!-- Link to query -->
[Join Queries](joins_queries.sql)