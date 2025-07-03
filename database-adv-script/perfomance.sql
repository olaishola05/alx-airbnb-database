-- Initial Query: Full joins across booking, user, property, and payment
SELECT 
    bks.booking_id,
    bks.start_date,
    bks.end_date,
    bks.total_price,
    bks.status,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method
FROM bookings AS bks
INNER JOIN users AS u ON bks.user_id = u.user_id
INNER JOIN properties AS p ON bks.property_id = p.property_id
LEFT JOIN payments AS pay ON bks.booking_id = pay.booking_id;

-- Analyze performance of initial query
EXPLAIN ANALYZE
SELECT 
    bks.booking_id,
    bks.start_date,
    bks.end_date,
    bks.total_price,
    bks.status,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method
FROM bookings AS bks
INNER JOIN users AS u ON bks.user_id = u.user_id
INNER JOIN properties AS p ON bks.property_id = p.property_id
LEFT JOIN payments AS pay ON bks.booking_id = pay.booking_id;

-- Refactored Query: Minimized fields for faster performance
EXPLAIN ANALYZE
SELECT 
    bks.booking_id,
    bks.start_date,
    bks.end_date,
    u.first_name || ' ' || u.last_name AS user_name,
    p.name AS property_name,
    pay.amount
FROM bookings AS bks
INNER JOIN users AS u ON bks.user_id = u.user_id
INNER JOIN properties AS p ON bks.property_id = p.property_id
LEFT JOIN payments AS pay ON bks.booking_id = pay.booking_id;
