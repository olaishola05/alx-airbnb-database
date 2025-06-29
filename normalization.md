# AirBnB Database Normalization to 3NF

## What is 3NF?

A database schema is in Third Normal Form (3NF) if:

- It is in Second Normal Form (2NF):
- No partial dependencies (non-prime attributes depend on the whole primary key).
- It has no transitive dependencies:
  - Non-key attributes depend only on the primary key, not on other non-key attributes.

## Step-by-Step Normalization Review

1. User Table

```sql
User(
  user_id, username, email, password_hash, created_at, updated_at
)
```

- Analysis: No repeating groups, no partial dependencies, and no transitive dependencies.

- Already in 3NF.

2. Property Table

```sql
Property(
  property_id, host_id, name, description, location,
  pricepernight, created_at, updated_at
)
```

- Analysis:
  - All non-key attributes depend fully on property_id.
  - No attributes are derived from others (e.g., location is atomic).

  - In 3NF.

3. Booking Table

```sql
Booking(
  booking_id, property_id, user_id, start_date, end_date,
  total_price, status, created_at
)
```

Observation:

- total_price could be considered derivable from (end_date - start_date) * pricepernight.

- However, keeping total_price is acceptable for historical price accuracy, especially if prices change over time.

- Considered denormalized by design, not a violation of 3NF.

4. Payment Table

```sql
Payment(
  payment_id, booking_id, amount, payment_date, payment_method
)
```

Analysis:

- All attributes depend only on payment_id.
- Amount is not derivable from other fields within this table.
- In 3NF.

5. Review Table

```sql
Review(
  review_id, property_id, user_id, rating, comment, created_at
)
```

Analysis:

- All fields directly relate to review_id.
- No transitive dependencies.
- In 3NF.

6. Message Table

```sql
Message(
  message_id, sender_id, recipient_id, message_body, sent_at
)
```

Analysis:

- All attributes depend on the primary key message_id.
- No transitive or partial dependencies.
- In 3NF.
