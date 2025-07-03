-- Users table
CREATE INDEX idx_users_user_id ON users(user_id);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Properties table
CREATE INDEX idx_properties_name ON properties(name);

-- Reviews table
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);

-- Optional composite index for frequent ordering
CREATE INDEX idx_property_name_rating ON reviews(property_id, rating DESC);

-- EXPLAIN ANALYZE Statements (run after indexes are created)
-- 1. High-rated properties
EXPLAIN ANALYZE
SELECT *
FROM properties AS p
WHERE p.property_id IN (
    SELECT property_id
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- 2. Frequent bookers
EXPLAIN ANALYZE
SELECT * 
FROM users AS u
WHERE EXISTS (
  SELECT * FROM bookings AS bks 
  WHERE u.user_id = bks.user_id
  GROUP BY bks.user_id
  HAVING COUNT(*) > 3
);

-- 3. Join on bookings and users
EXPLAIN ANALYZE
SELECT * 
FROM bookings AS bks
INNER JOIN users AS u ON bks.user_id = u.user_id;

-- 4. Join on properties and reviews with order
EXPLAIN ANALYZE
SELECT * 
FROM properties AS p
LEFT JOIN reviews AS r ON p.property_id = r.property_id
ORDER BY p.name, r.rating DESC;