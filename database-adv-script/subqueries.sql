SELECT *
FROM properties AS p
WHERE p.property_id IN (
    SELECT property_id
    FROM reviews
    GROUP By property_id
    HAVING AVG(rating)  > 4
)

SELECT * 
FROM users AS u
WHERE EXISTS (
  SELECT * FROM bookings AS bks WHERE u.user_id = bks.user_id
  GROUP BY bks.user_id
  HAVING COUNT(*) > 3
)