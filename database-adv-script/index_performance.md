# Index Performance Analysis for Airbnb Clone Backend

## Objective

To optimize query performance in the Airbnb Clone backend by identifying and indexing high-usage columns involved in frequent JOIN, WHERE, and ORDER BY clauses.

## 1. High-Usage Columns Identified

### Users Table

- `user_id`: Used in JOINs with `bookings`, `reviews`, `messages`
- `email`: Already indexed for uniqueness and lookup

### Bookings Table

- `user_id`: Used in WHERE and JOIN conditions
- `property_id`: Already indexed

### Properties Table

- `name`: Frequently used in ORDER BY
- `property_id`: Primary key (already indexed)

### Reviews Table

- `property_id`: Used in WHERE, JOINs
- `rating`: Used in HAVING and ORDER BY
- `user_id`: For JOINs and filtering by reviewer

## 2. Indexes Added

| Table     | Column(s)                         | Index Name                   |
|-----------|----------------------------------|------------------------------|
| users     | user_id                           | idx_users_user_id            |
| bookings  | user_id                           | idx_bookings_user_id         |
| properties| name                              | idx_properties_name          |
| reviews   | property_id                       | idx_reviews_property_id      |
| reviews   | rating                            | idx_reviews_rating           |
| reviews   | user_id                           | idx_reviews_user_id          |
| reviews   | property_id, rating DESC          | idx_property_name_rating     |

## 3. Measuring Performance: EXPLAIN and ANALYZE

Use `EXPLAIN ANALYZE` to measure query performance before and after adding indexes. Example:

```sql
EXPLAIN ANALYZE
SELECT *
FROM properties AS p
WHERE p.property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
```

Compare:

- Execution time
- Cost estimates
- Index usage indicators (Index Scan vs Seq Scan)

## 4. Expected Impacts

| Query Context                           | Expected Improvement                   |
| --------------------------------------- | -------------------------------------- |
| JOINs on `user_id`                      | Faster user-to-booking lookups         |
| JOINs on `property_id`                  | Reduced full scans in bookings/reviews |
| ORDER BY `rating DESC`, `name`          | Optimized sorting with composite index |
| WHERE conditions on `rating`, `user_id` | Faster filtering and grouping          |

## 5. Conclusion

Strategic indexing on high-usage columns significantly improves query execution speed and scalability, especially for JOIN-heavy queries and aggregation filtering. These indexes should be monitored over time for maintenance and performance tuning.
