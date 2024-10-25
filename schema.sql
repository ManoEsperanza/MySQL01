USE music;

CREATE TABLE tutors (
    tutor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    contact_number VARCHAR(12),
    name_of_qualification TEXT
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    tutor_id INT,
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id)
);

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    amount INT,
    payment_mode VARCHAR(100),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE session (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    occurrence DATETIME,
    venue VARCHAR(250),
    student_id INT,
    tutor_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id)
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT,
    student_id INT,
    tutor_id INT,
    payment_id INT,
    FOREIGN KEY (session_id) REFERENCES session(session_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (tutor_id) REFERENCES tutors(tutor_id),
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    blk_number VARCHAR(6),
    street_name VARCHAR(255),
    unit_number CHAR(10),
    postal_code CHAR(6),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);