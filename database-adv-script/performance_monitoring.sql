-- Bookings by a Specific User
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-uuid';

-- Average Rating for a Property
EXPLAIN ANALYZE
SELECT AVG(rating)
FROM reviews
WHERE property_id = 'some-property-id';


-- Top Properties by Bookings
EXPLAIN ANALYZE
SELECT p.property_id, p.name, COUNT(b.booking_id) AS bookings_count
FROM properties AS p
JOIN bookings AS b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY bookings_count DESC
LIMIT 5;

-- Observation:
-- A sequential scan is used on bookings, even though user_id is frequently filtered.
-- No index on property_id in reviews, leading to full table scan.
-- Aggregation is expensive.
-- bookings.property_id is indexed — good.
-- Consider materializing this if run frequently.

-- Apply Improvements

-- Adding Missing Index
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

