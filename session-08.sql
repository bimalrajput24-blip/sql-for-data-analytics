 ##======================= session 08==============
 
/* 1.
<p>Create a database `tiffin_service_db` with tables `customers` (customer_id primary key, customer_name, area, plan_type)
 and `orders` (order_id primary key, customer_id foreign key to customers, order_date, meal_type, amount_inr)
 in `tiffin_joins.sql`. Insert 8 fictional customers and 20 orders placed by only 6 of them, with amounts from 60 to 180.
 Hint: Create `customers` first and use `FOREIGN KEY (customer_id) REFERENCES customers(customer_id)`.</p>*/
 
 CREATE DATABASE IF NOT EXISTS tiffin_service_db;


USE tiffin_service_db;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    area VARCHAR(100),
    plan_type VARCHAR(50)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    meal_type VARCHAR(50),
    amount_inr DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO customers
(customer_id, customer_name, area, plan_type)
VALUES
(1, 'Rahul Sharma', 'Adajan', 'Monthly'),
(2, 'Priya Patel', 'Vesu', 'Weekly'),
(3, 'Amit Shah', 'Varachha', 'Monthly'),
(4, 'Neha Desai', 'City Light', 'Daily'),
(5, 'Rohan Mehta', 'Katargam', 'Weekly'),
(6, 'Pooja Joshi', 'Pal', 'Monthly'),
(7, 'Karan Shah', 'Udhna', 'Daily'),
(8, 'Sneha Patel', 'Piplod', 'Weekly');



INSERT INTO orders
(order_id, customer_id, order_date, meal_type, amount_inr)
VALUES
(101, 1, '2026-11-01', 'Lunch', 80),
(102, 1, '2026-11-02', 'Dinner', 100),
(103, 1, '2026-11-03', 'Lunch', 120),
(104, 1, '2026-11-04', 'Dinner', 90),

(105, 2, '2026-11-01', 'Lunch', 60),
(106, 2, '2026-11-02', 'Dinner', 110),
(107, 2, '2026-11-03', 'Lunch', 130),

(108, 3, '2026-11-01', 'Dinner', 150),
(109, 3, '2026-11-02', 'Lunch', 100),
(110, 3, '2026-11-03', 'Dinner', 180),
(111, 3, '2026-11-04', 'Lunch', 140),

(112, 4, '2026-11-01', 'Lunch', 70),
(113, 4, '2026-11-02', 'Dinner', 90),
(114, 4, '2026-11-03', 'Lunch', 120),

(115, 5, '2026-11-01', 'Dinner', 160),
(116, 5, '2026-11-02', 'Lunch', 100),
(117, 5, '2026-11-03', 'Dinner', 130),

(118, 6, '2026-11-01', 'Lunch', 80),
(119, 6, '2026-11-02', 'Dinner', 150),
(120, 6, '2026-11-03', 'Lunch', 110);
 
 
 select * from customers;
 
 SELECT * FROM orders;
 
 
 
/*2.
<p>Write an INNER JOIN in `tiffin_joins.sql` that returns customer_name, area, order_date, meal_type and 
amount_inr for every order, joined on customer_id with table aliases `c` and `o`. The result must have exactly 20 rows and no customer who has no orders.</p>*/

SELECT
    c.customer_name,
    c.area,
    o.order_date,
    o.meal_type,
    o.amount_inr
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;


SELECT COUNT(*) AS total_rows
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;


/*3.
<p>Write a LEFT JOIN from `customers` to `orders` that returns the customers who have never placed an order, with their customer_name and area. 
The result must have exactly 2 rows. Add it to `tiffin_joins.sql`. Hint: Unmatched rows have NULL on the right side, so filter with `WHERE o.order_id IS NULL`.</p>*/

SELECT
    c.customer_name,
    c.area
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


/*4.
<p>Finish `tiffin_joins.sql` by writing the same never-ordered customers query using RIGHT JOIN, with `orders` on 
the left and `customers` on the right. Run the whole file and check both queries return the same 2 customers.</p>*/

SELECT
    c.customer_name,
    c.area
FROM orders AS o
RIGHT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

SELECT c.customer_name, c.area
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
