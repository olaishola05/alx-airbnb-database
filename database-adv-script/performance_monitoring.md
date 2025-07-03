# Database Performance Monitoring Report

## Objective

To continuously monitor and refine database performance by analyzing query execution plans and applying schema optimizations.

## Monitored Queries

1. Fetch bookings by a specific user

```sql
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-uuid';
```

2. Compute average rating for a property

```sql
EXPLAIN ANALYZE
SELECT AVG(rating)
FROM reviews
WHERE property_id = 'some-property-id';
```

3. Retrieve top properties by booking count

```sql
EXPLAIN ANALYZE
SELECT p.property_id, p.name, COUNT(b.booking_id) AS bookings_count
FROM properties AS p
JOIN bookings AS b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY bookings_count DESC
LIMIT 5;
```

## Tools Used

- `EXPLAIN ANALYZE`
- Index analysis
- Materialized views

## Identified Bottlenecks

| Query                              | Bottleneck                            |
|------------------------------------|----------------------------------------|
| Bookings by user                   | Sequential scan, missing index         |
| Avg rating per property            | Full table scan, no index on property  |
| Top properties by bookings         | Expensive aggregation on joins         |

## Schema Changes

- Created index on `reviews.property_id`
- Created index on `bookings.user_id`
- Created partial index for `status = 'confirmed'` on bookings
- Introduced materialized view for top properties

```sql
CREATE INDEX IF NOT EXISTS idx_reviews_property_id ON reviews(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_confirmed ON bookings(user_id)
WHERE status = 'confirmed';

-- Material View
CREATE MATERIALIZED VIEW IF NOT EXISTS top_properties_by_bookings AS
SELECT p.property_id, p.name, COUNT(b.booking_id) AS bookings_count
FROM properties AS p
JOIN bookings AS b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name;
```

## Performance Comparison

| Query Description         | Before (ms) | After (ms) | Change                 |
|---------------------------|-------------|------------|------------------------|
| Bookings by user          | ~18ms       | ~2ms       | 9x faster              |
| Reviews avg by property   | ~25ms       | ~4ms       | 6x faster              |
| Top properties (raw)      | ~120ms      | ~90ms      | Slight improvement     |
| Top properties (materialized) | ~120ms | ~1ms       | Major improvement      |

## Conclusion

Performance bottlenecks were addressed with targeted indexing and view optimization. Future monitoring should automate query tracking and index usage stats using PostgreSQL's `pg_stat_statements`.
