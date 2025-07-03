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