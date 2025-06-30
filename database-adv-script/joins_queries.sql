SELECT * FROM bookings AS bks
INNER JOIN users AS u ON bks.user_id = u.user_id


SELECT * FROM properties AS p
LEFT JOIN reviews AS r ON p.property_id = r.property_id


SELECT * 
FROM users AS u
FULL OUTER JOIN bookings AS b ON u.user_id = b.user_id