SELECT user_id, COUNT(user_id) AS total_number_bookings 
FROM bookings bks
GROUP BY user_id

WITH PropertyBookings AS(
SELECT
  p.property_id,
  p.name,
  COUNT(bks.property_id) AS total_number_bookings
FROM properties AS p
INNER JOIN
bookings AS bks ON p.property_id = bks.property_id
GROUP BY p.property_id, p.name
)

SELECT
  property_id,
  name,
  total_number_bookings,
  ROW_NUMBER() OVER (ORDER BY total_number_bookings DESC) as RowNumberByBookings,
  RANK() OVER (ORDER BY total_number_bookings DESC) AS RankByBookings
FROM PropertyBookings