# Index Perfomance

### My approach

Added indexes to frequently queried columns to optimize performance.
Using EXPLAIN, we verified that MySQL used idx_property_id_booking,
but also created a composite index idx_booking_user_property to improve filtering when both user_id and property_id are present in queries.
The query planner may choose between these based on estimated selectivity.
