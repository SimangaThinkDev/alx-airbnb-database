
# 🚀 Seeding the Database

A small sample of realistic data is provided in a DML script:

    3 users (guest, host, admin)

    1 property

    1 booking + payment + review

    1 message between users

Use psql or an SQL client to run the seed script after initializing the schema.

📂 Usage Instructions
Create the database.

## Enable extensions:
1. Create the database.

2. Enable extensions:
```sql
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```
3. Run the schema SQL file.

4. Run the seed data file (optional).

