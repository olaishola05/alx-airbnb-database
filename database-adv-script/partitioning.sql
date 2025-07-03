-- Step 1: Rename the original bookings table
ALTER TABLE bookings RENAME TO bookings_old;

-- Step 2: Create the new partitioned bookings table
CREATE TABLE bookings (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Step 3: Create partitions by year (example: 2023 and 2024)
CREATE TABLE bookings_2023 PARTITION OF bookings
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Step 4: Recreate indexes on each partition if necessary
CREATE INDEX idx_bookings_2023_user_id ON bookings_2023(user_id);
CREATE INDEX idx_bookings_2024_user_id ON bookings_2024(user_id);

-- Step 5: Migrate data from old table (optional for testing)
INSERT INTO bookings
SELECT * FROM bookings_old;

-- Step 6: Drop the old table (only if tested and backed up)
-- DROP TABLE bookings_old;

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';
