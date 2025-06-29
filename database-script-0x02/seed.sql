INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
  ('00000000-0000-0000-0000-000000000001', 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '555-1234', 'host'),
  ('00000000-0000-0000-0000-000000000002', 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '555-5678', 'guest'),
  ('00000000-0000-0000-0000-000000000003', 'Carol', 'Lee', 'carol@example.com', 'hashed_pw3', '555-9012', 'guest');


INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES
  ('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Sunny Apartment', 'A cozy and sunny 2-bedroom apartment.', 'New York, NY', 120.00),
  ('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Mountain Cabin', 'A quiet cabin in the mountains.', 'Aspen, CO', 200.00);

INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  ('20000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', '2025-07-01', '2025-07-05', 480.00, 'confirmed'),
  ('20000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003', '2025-08-10', '2025-08-13', 600.00, 'pending');


INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
  ('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001', 480.00, 'credit_card');


INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
  ('40000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 5, 'Wonderful stay, very clean and cozy!'),
  ('40000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000003', 4, 'Peaceful retreat but a bit cold at night.');


INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
  ('50000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'Hi, is the Sunny Apartment available in July?'),
  ('50000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002', 'Yes, it’s available from the 1st to 5th!');
