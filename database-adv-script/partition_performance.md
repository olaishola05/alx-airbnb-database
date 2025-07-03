# Partitioning Performance Report – Bookings Table

## Objective

To optimize query performance on the large `bookings` table by implementing range-based partitioning using the `start_date` column.

## Partitioning Strategy

The `bookings` table was partitioned by **year ranges** based on the `start_date` column:

- `bookings_2023`: Bookings from 2023
- `bookings_2024`: Bookings from 2024

This method allows the database engine to skip irrelevant partitions when filtering by date, reducing scan time.

## Query Used for Benchmark

```sql
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';
```

## Performance Comparison

| Metric                  | Before Partitioning | After Partitioning             |
| ----------------------- | ------------------- | ------------------------------ |
| Execution Time (Sample) | \~80ms              | \~12ms                         |
| Rows Scanned            | 10,000+             | \~2,500                        |
| Scan Type               | Sequential Scan     | Index Scan + Partition Pruning |

Note: Values are estimates and depend on dataset size.

## Observations

- The partitioned table enabled partition pruning, where only relevant sub-tables were queried.
- Indexes on partitions significantly improved query execution time.
- For date-based queries, partitioning drastically reduced I/O and processing overhead.

## Conclusion

Partitioning the bookings table by start_date effectively improved query performance. This approach is recommended for time-series-like data or tables with predictable query patterns over time.
