##======================= session 15==============


/*1.
<p>Create a database `gym_membership_db` and a table `members` (member_id primary key, member_name, joined_on DATE, plan_months INT, last_visit DATE) in `gym_dates.sql`.
 Insert 15 fictional members who joined between 2025-06-01 and 2026-10-31, with plan_months of 1, 3, 6 or 12, last_visit dates between 2026-09-01 and 2026-11-15, 
 and at least 3 memberships expiring in December 2026.</p>*/
 
 CREATE DATABASE IF NOT EXISTS gym_membership_db;
 
USE gym_membership_db;


CREATE TABLE IF NOT EXISTS members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    joined_on DATE NOT NULL,
    plan_months INT NOT NULL,
    last_visit DATE,
    CHECK (plan_months IN (1, 3, 6, 12))
);

INSERT INTO members (member_id, member_name, joined_on, plan_months, last_visit) VALUES
(1,  'Aarav Sharma',   '2025-06-12', 12, '2026-11-20'),
(2,  'Priya Patel',    '2025-09-05',  6, '2026-11-18'),
(3,  'Rahul Verma',    '2026-06-15',  6, '2026-11-15'), 
(4,  'Neha Desai',     '2026-09-01',  3, '2026-11-12'), 
(5,  'Karan Mehta',    '2025-12-10', 12, '2026-11-10'), 
(6,  'Ananya Singh',   '2026-01-20',  3, '2026-11-08'),
(7,  'Vivek Joshi',    '2026-03-14',  6, '2026-11-05'),
(8,  'Isha Shah',      '2026-10-01',  1, '2026-11-03'),
(9,  'Rohan Gupta',    '2025-08-22', 12, '2026-10-30'),
(10, 'Meera Iyer',     '2026-07-07',  3, '2026-10-28'),
(11, 'Arjun Nair',     '2026-04-18',  6, '2026-10-25'),
(12, 'Kavya Rao',      '2026-10-15',  1, '2026-10-20'),
(13, 'Sahil Khan',     '2025-11-02', 12, '2026-10-15'),
(14, 'Pooja Kulkarni', '2026-08-09',  3, '2026-09-25'),
(15, 'Dev Malhotra',   '2026-02-11',  1, '2026-09-10');


SELECT
    member_id,
    member_name,
    joined_on,
    plan_months,
    DATE_ADD(joined_on, INTERVAL plan_months MONTH) AS expiry_date,
    last_visit
FROM members
ORDER BY member_id;


SELECT member_id, member_name,
       DATE_ADD(joined_on, INTERVAL plan_months MONTH) AS expiry_date
FROM members
WHERE DATE_ADD(joined_on, INTERVAL plan_months MONTH)
      BETWEEN '2026-12-01' AND '2026-12-31'
ORDER BY expiry_date;
 
 
 
/*2.
<p>Write a query in `gym_dates.sql` returning member_name, `join_year`, `join_month` and `join_day` (using YEAR, MONTH and DAY), `checked_at` (using NOW()) and `today_only` (using DATE(NOW())). 
The result must have 15 rows. Hint: `NOW()` returns date and time, `DATE()` keeps only the date.</p>*/

SELECT
    member_name,
    YEAR(joined_on) AS join_year,
    MONTH(joined_on) AS join_month,
    DAY(joined_on) AS join_day,
    NOW() AS checked_at,
    DATE(NOW()) AS today_only
FROM members
ORDER BY member_id;



/*3.
<p>Write a query that returns member_name, `expiry_date` using `DATE_ADD(joined_on, INTERVAL plan_months MONTH)` and `reminder_date` using DATE_SUB to give 7 days before expiry.
 Add it to `gym_dates.sql`. Both columns must hold valid dates for all 15 rows, and you check two rows by hand on a calendar.</p>*/
 
 SELECT
    member_name,
    DATE_ADD(joined_on, INTERVAL plan_months MONTH) AS expiry_date,
    DATE_SUB(
        DATE_ADD(joined_on, INTERVAL plan_months MONTH),
        INTERVAL 7 DAY
    ) AS reminder_date
FROM members
ORDER BY member_id;
 

 
/*4.
<p>Finish `gym_dates.sql` with a query that uses DATEDIFF and the fixed reference date '2026-11-30' to return members whose expiry_date falls within the 30 days after that date, with `days_left`. 
Run the whole file and make sure at least 2 members are returned. Hint: Repeat the expiry expression, since an alias cannot be used in WHERE.</p>*/

SELECT
    member_name,
    DATE_ADD(joined_on, INTERVAL plan_months MONTH) AS expiry_date,
    DATEDIFF(
        DATE_ADD(joined_on, INTERVAL plan_months MONTH),
        '2026-11-30'
    ) AS days_left
FROM members
WHERE DATEDIFF(
    DATE_ADD(joined_on, INTERVAL plan_months MONTH),
    '2026-11-30'
) BETWEEN 1 AND 30
ORDER BY expiry_date;



