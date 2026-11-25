
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
