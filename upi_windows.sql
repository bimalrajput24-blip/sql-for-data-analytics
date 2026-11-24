##======================= session 13==============


/*1.
<p>Create a database `upi_payments_db` and a table `payments` (payment_id primary key, sender_handle, merchant_category, amount_inr, paid_on DATE) in `upi_windows.sql`. Insert 24 fictional UPI-style payments from 6 invented handles such as 'asha@fictbank', 
in 4 categories, with amounts from 20 to 4,000, dates in October 2026, and two payments in one category having exactly the same amount.</p>*/


CREATE DATABASE IF NOT EXISTS upi_payments_db;

USE upi_payments_db;

DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    sender_handle VARCHAR(100) NOT NULL,
    merchant_category VARCHAR(50) NOT NULL,
    amount_inr DECIMAL(10, 2) NOT NULL,
    paid_on DATE NOT NULL
);

INSERT INTO payments
    (payment_id, sender_handle, merchant_category, amount_inr, paid_on)
VALUES
    (1,  'asha@fictbank',   'Groceries',       850.00,  '2026-10-01'),
    (2,  'rohan@mockupi',   'Food',            220.00,  '2026-10-02'),
    (3,  'meera@samplepay', 'Transport',        75.00,  '2026-10-03'),
    (4,  'kabir@fictbank',  'Shopping',       2400.00,  '2026-10-04'),
    (5,  'nisha@mockupi',   'Groceries',      1250.00,  '2026-10-05'),
    (6,  'dev@samplepay',   'Food',            180.00,  '2026-10-06'),
    (7,  'asha@fictbank',   'Transport',       120.00,  '2026-10-07'),
    (8,  'rohan@mockupi',   'Shopping',       3999.00,  '2026-10-08'),
    (9,  'meera@samplepay', 'Groceries',       640.00,  '2026-10-09'),
    (10, 'kabir@fictbank',  'Food',            450.00,  '2026-10-10'),
    (11, 'nisha@mockupi',   'Transport',        75.00,  '2026-10-11'),
    (12, 'dev@samplepay',   'Shopping',       1800.00,  '2026-10-12'),
    (13, 'asha@fictbank',   'Food',            320.00,  '2026-10-13'),
    (14, 'rohan@mockupi',   'Groceries',      2100.00,  '2026-10-14'),
    (15, 'meera@samplepay', 'Shopping',        999.00,  '2026-10-15'),
    (16, 'kabir@fictbank',  'Transport',        40.00,  '2026-10-16'),
    (17, 'nisha@mockupi',   'Food',            220.00,  '2026-10-17'),
    (18, 'dev@samplepay',   'Groceries',      4000.00,  '2026-10-18'),
    (19, 'asha@fictbank',   'Shopping',       1550.00,  '2026-10-19'),
    (20, 'rohan@mockupi',   'Transport',        95.00,  '2026-10-20'),
    (21, 'meera@samplepay', 'Food',           1200.00,  '2026-10-21'),
    (22, 'kabir@fictbank',  'Groceries',       850.00,  '2026-10-22'),
    (23, 'nisha@mockupi',   'Shopping',        520.00,  '2026-10-23'),
    (24, 'dev@samplepay',   'Transport',       300.00,  '2026-10-24');

SELECT * FROM payments ORDER BY payment_id;


/*2.
<p>Write a query in `upi_windows.sql` that returns every payment with `overall_avg` (AVG(amount_inr) OVER ()) and `diff_from_avg`,
 both rounded to 2 decimals. The result must keep all 24 rows. Hint: A window function does not collapse rows like GROUP BY does.</p>*/
 
 SELECT
    payment_id,
    sender_handle,
    merchant_category,
    amount_inr,
    paid_on,
    ROUND(AVG(amount_inr) OVER (), 2) AS overall_avg,
    ROUND(amount_inr - AVG(amount_inr) OVER (), 2) AS diff_from_avg
FROM payments
ORDER BY payment_id;

 
/*3.
<p>Write a query that uses AVG and SUM with `PARTITION BY merchant_category` to show each payment, its category average, its category total and its percentage
 share of the category total. Add it to `upi_windows.sql`. The result must keep 24 rows. Constraint: Do not use GROUP BY or a subquery.</p>*/
 SELECT
    payment_id,
    sender_handle
  merchant_category,
    amount_inr,
    paid_on,
    ROUND(
        AVG(amount_inr) OVER (
            PARTITION BY merchant_category
        ), 2
    ) AS category_avg,
    ROUND(
        SUM(amount_inr) OVER (
            PARTITION BY merchant_category
        ), 2
    ) AS category_total,
    ROUND(
        amount_inr * 100.0 /
        SUM(amount_inr) OVER (
            PARTITION BY merchant_category
        ), 2
    ) AS category_share_pct
FROM payments
ORDER BY merchant_category, payment_id;
 
 
/*4.
<p>Finish `upi_windows.sql` with a running total query per sender_handle, using `SUM(amount_inr) OVER (PARTITION BY sender_handle ORDER BY paid_on, payment_id)`,
 returning sender_handle, paid_on, amount_inr and `running_total_inr`. Check that each sender's last running total equals that sender's total spend.</p>*/
 
 SELECT
    sender_handle,
    paid_on,
    amount_inr,
    SUM(amount_inr) OVER (
        PARTITION BY sender_handle
        ORDER BY paid_on, payment_id
    ) AS running_total_inr
FROM payments
ORDER BY sender_handle, paid_on, payment_id;