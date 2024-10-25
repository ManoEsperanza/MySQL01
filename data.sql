USE music;

INSERT INTO tutors (tutor_id, first_name, last_name, contact_number, name_of_qualification) VALUES
('1', 'Mano', 'Esperanza', '88231243', 'Grade 9 Classical Guitar at Laselle'),
('2', 'John', 'Parker', '9001123', 'Diploma in Music in the Contemporary School of Arts UK'),
('3', 'Jason', 'Soh', '88908292', 'Grade 8 Electric Guitar at NAFA');

INSERT INTO students (first_name, last_name, date_of_birth, tutor_id) VALUES
('Leo', 'Cole', '2003-04-23', '1'),
('Rebecca', 'Low', '2003-09-18', '2'),
('Siti Aminah',' Binte Muhammad Ilham', '2002-08-30', '3');

INSERT INTO payment (payment_id, amount, payment_mode, student_id) VALUES
('1', '240', 'Credit Card', '1'),
('2', '235', 'Cash', '2'),
('3', '200', 'Atome', '3');

INSERT INTO session (session_id, occurrence, venue, student_id, tutor_id) VALUES
('1', '2024-04-28 15:30:01', '12 Orchard Road', '1', '1'),
('2', '2024-05-15 16:00:40', '02 Jurong East', '2', '2'),
('3', '2024-06-12 15:30:03', '12 Orchard Road', '3', '3');

INSERT INTO attendance (session_id, student_id, tutor_id, payment_id) VALUES
('1', '1', '1', '1'),
('2', '2', '2', '2'),
('3', '3', '3', '3');

INSERT INTO address (address_id, blk_number, street_name, unit_number, postal_code, student_id) VALUES
('1', '12', 'Sentosa Cove', '01', '900121', '1'),
('2', '394', 'Chua Chu Kang', '12-110', '823410', '2'),
('3', '920', 'Jalan Petir', '05-234', '490203', '3');