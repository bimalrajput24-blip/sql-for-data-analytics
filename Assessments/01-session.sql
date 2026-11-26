
/*
SCENARIO -1
You are a data analyst at a food delivery platform. The operations team needs a report
showing which restaurant partners earned more than Rs 1,00,000 in total revenue last
month — but only for restaurants that received at least 50 orders.

Question: Explain how you would use GROUP BY and HAVING together to produce this report.
Why is HAVING more appropriate than WHERE for filtering on aggregated values? What would
break in your query if you replaced HAVING with WHERE?

*/
drop database if exists food_delivery_db;
CREATE DATABASE food_delivery_db;

USE food_delivery_db;

CREATE TABLE restaurant_orders (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    order_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO restaurant_orders
(order_id, restaurant_name, order_date, order_amount)
VALUES
-- Restaurant A: 50 orders, total revenue ₹1,25,000
(1, 'Pizza Palace', '2026-10-05', 2500),
(2, 'Pizza Palace', '2026-10-06', 2500),
(3, 'Pizza Palace', '2026-10-07', 2500),
(4, 'Pizza Palace', '2026-10-08', 2500),
(5, 'Pizza Palace', '2026-10-09', 2500),
(6, 'Pizza Palace', '2026-10-10', 2500),
(7, 'Pizza Palace', '2026-10-11', 2500),
(8, 'Pizza Palace', '2026-10-12', 2500),
(9, 'Pizza Palace', '2026-10-13', 2500),
(10, 'Pizza Palace', '2026-10-14', 2500),
(11, 'Pizza Palace', '2026-10-15', 2500),
(12, 'Pizza Palace', '2026-10-16', 2500),
(13, 'Pizza Palace', '2026-10-17', 2500),
(14, 'Pizza Palace', '2026-10-18', 2500),
(15, 'Pizza Palace', '2026-10-19', 2500),
(16, 'Pizza Palace', '2026-10-20', 2500),
(17, 'Pizza Palace', '2026-10-21', 2500),
(18, 'Pizza Palace', '2026-10-22', 2500),
(19, 'Pizza Palace', '2026-10-23', 2500),
(20, 'Pizza Palace', '2026-10-24', 2500),
(21, 'Pizza Palace', '2026-10-25', 2500),
(22, 'Pizza Palace', '2026-10-26', 2500),
(23, 'Pizza Palace', '2026-10-27', 2500),
(24, 'Pizza Palace', '2026-10-28', 2500),
(25, 'Pizza Palace', '2026-10-29', 2500),
(26, 'Pizza Palace', '2026-10-30', 2500),
(27, 'Pizza Palace', '2026-10-31', 2500),
(28, 'Pizza Palace', '2026-10-05', 2500),
(29, 'Pizza Palace', '2026-10-06', 2500),
(30, 'Pizza Palace', '2026-10-07', 2500),
(31, 'Pizza Palace', '2026-10-08', 2500),
(32, 'Pizza Palace', '2026-10-09', 2500),
(33, 'Pizza Palace', '2026-10-10', 2500),
(34, 'Pizza Palace', '2026-10-11', 2500),
(35, 'Pizza Palace', '2026-10-12', 2500),
(36, 'Pizza Palace', '2026-10-13', 2500),
(37, 'Pizza Palace', '2026-10-14', 2500),
(38, 'Pizza Palace', '2026-10-15', 2500),
(39, 'Pizza Palace', '2026-10-16', 2500),
(40, 'Pizza Palace', '2026-10-17', 2500),
(41, 'Pizza Palace', '2026-10-18', 2500),
(42, 'Pizza Palace', '2026-10-19', 2500),
(43, 'Pizza Palace', '2026-10-20', 2500),
(44, 'Pizza Palace', '2026-10-21', 2500),
(45, 'Pizza Palace', '2026-10-22', 2500),
(46, 'Pizza Palace', '2026-10-23', 2500),
(47, 'Pizza Palace', '2026-10-24', 2500),
(48, 'Pizza Palace', '2026-10-25', 2500),
(49, 'Pizza Palace', '2026-10-26', 2500),
(50, 'Pizza Palace', '2026-10-27', 2500),
(51, 'Burger Hub', '2026-10-05', 1800),
(52, 'Burger Hub', '2026-10-06', 1800),
(53, 'Burger Hub', '2026-10-07', 1800),
(54, 'Burger Hub', '2026-10-08', 1800),
(55, 'Burger Hub', '2026-10-09', 1800),
(56, 'Burger Hub', '2026-10-10', 1800),
(57, 'Burger Hub', '2026-10-11', 1800),
(58, 'Burger Hub', '2026-10-12', 1800),
(59, 'Burger Hub', '2026-10-13', 1800),
(60, 'Burger Hub', '2026-10-14', 1800),
(61, 'Burger Hub', '2026-10-15', 1800),
(62, 'Burger Hub', '2026-10-16', 1800),
(63, 'Burger Hub', '2026-10-17', 1800),
(64, 'Burger Hub', '2026-10-18', 1800),
(65, 'Burger Hub', '2026-10-19', 1800),
(66, 'Burger Hub', '2026-10-20', 1800),
(67, 'Burger Hub', '2026-10-21', 1800),
(68, 'Burger Hub', '2026-10-22', 1800),
(69, 'Burger Hub', '2026-10-23', 1800),
(70, 'Burger Hub', '2026-10-24', 1800),
(71, 'Burger Hub', '2026-10-25', 1800),
(72, 'Burger Hub', '2026-10-26', 1800),
(73, 'Burger Hub', '2026-10-27', 1800),
(74, 'Burger Hub', '2026-10-28', 1800),
(75, 'Burger Hub', '2026-10-29', 1800),
(76, 'Burger Hub', '2026-10-30', 1800),
(77, 'Burger Hub', '2026-10-31', 1800),
(78, 'Burger Hub', '2026-10-05', 1800),
(79, 'Burger Hub', '2026-10-06', 1800),
(80, 'Burger Hub', '2026-10-07', 1800),
(81, 'Burger Hub', '2026-10-08', 1800),
(82, 'Burger Hub', '2026-10-09', 1800),
(83, 'Burger Hub', '2026-10-10', 1800),
(84, 'Burger Hub', '2026-10-11', 1800),
(85, 'Burger Hub', '2026-10-12', 1800),
(86, 'Burger Hub', '2026-10-13', 1800),
(87, 'Burger Hub', '2026-10-14', 1800),
(88, 'Burger Hub', '2026-10-15', 1800),
(89, 'Burger Hub', '2026-10-16', 1800),
(90, 'Burger Hub', '2026-10-17', 1800),
(91, 'Burger Hub', '2026-10-18', 1800),
(92, 'Burger Hub', '2026-10-19', 1800),
(93, 'Burger Hub', '2026-10-20', 1800),
(94, 'Burger Hub', '2026-10-21', 1800),
(95, 'Burger Hub', '2026-10-22', 1800),
(96, 'Burger Hub', '2026-10-23', 1800),
(97, 'Burger Hub', '2026-10-24', 1800),
(98, 'Burger Hub', '2026-10-25', 1800),
(99, 'Burger Hub', '2026-10-26', 1800),
(100, 'Burger Hub', '2026-10-27', 1800);


SELECT
    restaurant_name,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue
FROM restaurant_orders
WHERE order_date >= '2026-10-01'
  AND order_date < '2026-11-01'
GROUP BY restaurant_name
HAVING COUNT(order_id) >= 50
   AND SUM(order_amount) > 100000;



/*SCENARIO - 2
You are building a customer insights report for a food delivery app. The marketing team
needs a list of every registered customer and their most recent order details — even for
customers who have never placed an order.

Question: Which type of JOIN would you use to ensure all customers appear in the result,
including those with no orders? Justify your choice by comparing it with INNER JOIN, and explain
specifically what data would be lost if INNER JOIN were used instead.

*/

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1, 'Rahul', 'Surat'),
(2, 'Priya', 'Mumbai'),
(3, 'Amit', 'Ahmedabad'),
(4, 'Neha', 'Delhi'),
(5, 'Karan', 'Pune');

INSERT INTO orders VALUES
(101, 1, '2026-11-10', 500),
(102, 1, '2026-11-20', 800),
(103, 2, '2026-11-15', 650),
(104, 3, '2026-11-18', 900),
(105, 3, '2026-11-22', 1200);


SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.order_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date DESC;

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.order_amount
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
    
    
  /*  SCENARIO -- 3
You are designing a delivery performance dashboard. The business wants to identify
delivery agents whose average delivery time is faster than the overall platform average,
without using a temporary table or creating a new view.

Question: Describe how you would write a subquery to find these agents. What type of
subquery is most appropriate here — scalar, row, or table — and why? What would happen if you
tried to place this subquery in the SELECT clause instead of the WHERE clause?
    
    
*/

CREATE TABLE delivery_performance (
    delivery_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    delivery_time INT
);


INSERT INTO delivery_performance
(delivery_id, agent_name, delivery_time)
VALUES
(1, 'Rahul', 25),
(2, 'Rahul', 30),
(3, 'Rahul', 35),
(4, 'Priya', 40),
(5, 'Priya', 45),
(6, 'Priya', 50),
(7, 'Amit', 30),
(8, 'Amit', 35),
(9, 'Amit', 40),
(10, 'Neha', 50),
(11, 'Neha', 55),
(12, 'Neha', 60);

SELECT
    agent_name,
    ROUND(AVG(delivery_time), 2) AS avg_delivery_time
FROM delivery_performance
GROUP BY agent_name
HAVING AVG(delivery_time) < (
    SELECT AVG(delivery_time)
    FROM delivery_performance
);

SELECT AVG(delivery_time)
FROM delivery_performance;

/* SCENARIO -- 4
You are analysing order data for a food delivery company. The product team wants to
rank the top 3 highest-revenue restaurants within each city. Two restaurants in Surat
have the exact same revenue figure and you must decide how to number them.


Question: Compare RANK() and DENSE_RANK() window functions for this use case. Which would
you choose and why? Provide a brief example showing how each function would number three
restaurants where two share the same revenue, and explain the practical impact of that
difference on the product team's report.




*/

CREATE DATABASE restaurant_db;

USE restaurant_db;

CREATE TABLE restaurant_revenue (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city VARCHAR(50),
    revenue DECIMAL(12,2)
);

INSERT INTO restaurant_revenue
(restaurant_id, restaurant_name, city, revenue)
VALUES
(1, 'Pizza Palace', 'Surat', 150000),
(2, 'Burger Hub', 'Surat', 120000),
(3, 'Food Junction', 'Surat', 120000),
(4, 'Royal Kitchen', 'Surat', 100000),
(5, 'Spice Garden', 'Surat', 80000),
(6, 'Pizza Point', 'Mumbai', 200000),
(7, 'Burger King', 'Mumbai', 180000),
(8, 'Food Corner', 'Mumbai', 160000),
(9, 'Spicy Treat', 'Mumbai', 140000);

SELECT
    restaurant_name,
    city,
    revenue,
    RANK() OVER (
        PARTITION BY city
        ORDER BY revenue DESC
    ) AS restaurant_rank
FROM restaurant_revenue;

SELECT
    restaurant_name,
    city,
    revenue,
    DENSE_RANK() OVER (
        PARTITION BY city
        ORDER BY revenue DESC
    ) AS restaurant_rank
FROM restaurant_revenue;

/*SCENARIO -- 5
You are writing a CRM query for a food delivery startup. The customer success team
wants each customer labelled as 'Platinum', 'Gold', or 'Standard' based on total lifetime
spend — above Rs 5,000, between Rs 2,000 and Rs 5,000, and below Rs 2,000
respectively — directly in the query output without creating a new table.


Question: Explain how you would use CASE WHEN to generate this classification column. If a
customer's total spend is exactly Rs 5,000, which tier will they fall into, and how does the order of
your WHEN conditions control that outcome?


*/

CREATE DATABASE food_crm_db;

USE food_crm_db;

CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    order_amount DECIMAL(10,2)
);

INSERT INTO customer_orders
(order_id, customer_id, customer_name, order_amount)
VALUES
(1, 101, 'Rahul', 3000),
(2, 101, 'Rahul', 2500),
(3, 102, 'Priya', 2000),
(4, 102, 'Priya', 1500),
(5, 103, 'Amit', 1000),
(6, 103, 'Amit', 500),
(7, 104, 'Neha', 5000),
(8, 105, 'Karan', 1500);

SELECT
    customer_id,
    customer_name,
    SUM(order_amount) AS total_spend,

    CASE
        WHEN SUM(order_amount) > 5000
            THEN 'Platinum'

        WHEN SUM(order_amount) >= 2000
             AND SUM(order_amount) <= 5000
            THEN 'Gold'

        ELSE 'Standard'
    END AS customer_tier

FROM customer_orders
GROUP BY customer_id, customer_name
ORDER BY total_spend DESC;


/*SCENARIO -- 6
You are optimising a slow-running analytics query for a food delivery platform. The
query joins four large tables and applies a GROUP BY across 10 million rows, taking over
30 seconds. A colleague suggests adding an index on the JOIN column used most
frequently.


Question: Explain what a database index does at the engine level and why it would speed up
this specific query. Are there scenarios where adding an index could actually hurt performance?
What trade-off must you evaluate before indexing every column in a large table?



*/


