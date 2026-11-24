##======================= session 10 ==============

CREATE DATABASE IF NOT EXISTS fest_registrations_db;
USE fest_registrations_db;

-- Drop tables so the complete script can be rerun
DROP TABLE IF EXISTS workshop_registrations;
DROP TABLE IF EXISTS counter_registrations;
DROP TABLE IF EXISTS online_registrations;


CREATE TABLE online_registrations (
    reg_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    college VARCHAR(100),
    event_name VARCHAR(100),
    fee_inr DECIMAL(10,2),
    reg_date DATE
);

INSERT INTO online_registrations
(reg_id, student_name, college, event_name, fee_inr, reg_date)
VALUES
(1, 'Aarav Sharma', 'Sunrise Arts College', 'Dance Competition', 300, '2026-11-01'),
(2, 'Priya Patel', 'Greenfield Science College', 'Singing Competition', 200, '2026-11-02'),
(3, 'Rahul Mehta', 'Sunrise Arts College', 'Photography', 150, '2026-11-03'),
(4, 'Neha Shah', 'Silver Oak College', 'Coding Challenge', 500, '2026-11-04'),
(5, 'Karan Desai', 'Greenfield Science College', 'Dance Competition', 300, '2026-11-05'),
(6, 'Sneha Joshi', 'Sunrise Arts College', 'Fashion Show', 400, '2026-11-06'),
(7, 'Vikas Kumar', 'Riverdale Commerce College', 'Quiz Competition', 100, '2026-11-07'),
(8, 'Pooja Mehta', 'Silver Oak College', 'Photography', 150, '2026-11-08'),
(9, 'Rohan Patel', 'Greenfield Science College', 'Coding Challenge', 500, '2026-11-09'),
(10, 'Isha Shah', 'Riverdale Commerce College', 'Singing Competition', 200, '2026-11-10'),
(11, 'Dev Patel', 'Sunrise Arts College', 'Dance Competition', 300, '2026-11-11'),
(12, 'Ananya Desai', 'Silver Oak College', 'Fashion Show', 400, '2026-11-12');


CREATE TABLE counter_registrations (
    reg_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    college VARCHAR(100),
    event_name VARCHAR(100),
    fee_inr DECIMAL(10,2),
    reg_date DATE
);

INSERT INTO counter_registrations
(reg_id, student_name, college, event_name, fee_inr, reg_date)
VALUES
(101, 'Aarav Sharma', 'Sunrise Arts College', 'Dance Competition', 300, '2026-11-13'),
(102, 'Priya Patel', 'Greenfield Science College', 'Singing Competition', 200, '2026-11-13'),
(103, 'Rahul Mehta', 'Sunrise Arts College', 'Photography', 150, '2026-11-14'),
(104, 'Mehul Shah', 'Silver Oak College', 'Quiz Competition', 100, '2026-11-14'),
(105, 'Tanvi Joshi', 'Riverdale Commerce College', 'Fashion Show', 400, '2026-11-15'),
(106, 'Harsh Patel', 'Greenfield Science College', 'Coding Challenge', 500, '2026-11-15'),
(107, 'Mira Desai', 'Silver Oak College', 'Singing Competition', 200, '2026-11-16'),
(108, 'Dev Patel', 'Sunrise Arts College', 'Dance Competition', 300, '2026-11-16'),
(109, 'Diya Shah', 'Riverdale Commerce College', 'Photography', 150, '2026-11-17'),
(110, 'Manav Kumar', 'Greenfield Science College', 'Quiz Competition', 100, '2026-11-17'),
(111, 'Nisha Patel', 'Silver Oak College', 'Fashion Show', 400, '2026-11-18'),
(112, 'Kabir Sharma', 'Riverdale Commerce College', 'Coding Challenge', 500, '2026-11-18');


SELECT
    reg_id, student_name, college, event_name,
    fee_inr, reg_date, 'Online' AS source
FROM online_registrations
UNION ALL
SELECT
    reg_id, student_name, college, event_name,
    fee_inr, reg_date, 'Counter' AS source
FROM counter_registrations
ORDER BY reg_date;


SELECT student_name, college, event_name
FROM online_registrations
UNION
SELECT student_name, college, event_name
FROM counter_registrations;


CREATE TABLE workshop_registrations (
    reg_id INT PRIMARY KEY,
    event_name VARCHAR(100),
    reg_date DATE,
    student_name VARCHAR(100),
    fee_inr DECIMAL(10,2),
    college VARCHAR(100)
);

INSERT INTO workshop_registrations
(reg_id, event_name, reg_date, student_name, fee_inr, college)
VALUES
(201, 'AI Workshop', '2026-11-19', 'Aditi Rao', 250, 'Bluebell Engineering College'),
(202, 'Photography Workshop', '2026-11-19', 'Ishaan Verma', 350, 'Horizon Management College'),
(203, 'Web Development Workshop', '2026-11-20', 'Kavya Nair', 500, 'Sunrise Arts College'),
(204, 'Entrepreneurship Workshop', '2026-11-20', 'Arjun Singh', 400, 'Greenfield Science College'),
(205, 'Design Thinking Workshop', '2026-11-21', 'Meera Shah', 200, 'Silver Oak College'),
(206, 'Robotics Workshop', '2026-11-21', 'Vivaan Patel', 450, 'Riverdale Commerce College');


SELECT
    reg_id,
    student_name,
    college,
    event_name,
    fee_inr,
    reg_date,
    'Online' AS source
FROM online_registrations

UNION ALL

SELECT
    reg_id,
    student_name,
    college,
    event_name,
    fee_inr,
    reg_date,
    'Counter' AS source
FROM counter_registrations

UNION ALL

SELECT
    reg_id,
    student_name,
    college,
    event_name,
    fee_inr,
    reg_date,
    'Workshop' AS source
FROM workshop_registrations
ORDER BY reg_date;


SELECT COUNT(*) AS total_registrations
FROM (
    SELECT reg_id FROM online_registrations
    UNION ALL
    SELECT reg_id FROM counter_registrations
    UNION ALL
    SELECT reg_id FROM workshop_registrations
) AS all_registrations;
