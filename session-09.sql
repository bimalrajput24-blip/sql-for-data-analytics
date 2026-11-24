##======================= session 09==============



/*1.
<p>In `tiffin_service_db`, create `delivery_partners` (partner_id primary key, partner_name, manager_id) with 8 fictional partners, 2 of them having no manager, and write a SELF JOIN with LEFT JOIN that returns each partner_name with their manager's name as `manager_name`.
 Save it as `tiffin_advanced_joins.sql`. The result must have 8 rows, with NULL for the 2 top managers.</p>*/
 
 CREATE DATABASE IF NOT EXISTS tiffin_service_db;

USE tiffin_service_db;


CREATE TABLE delivery_partners (
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(100),
    manager_id INT
);


INSERT INTO delivery_partners
(partner_id, partner_name, manager_id)
VALUES
(1, 'Rajesh Kumar', NULL),
(2, 'Amit Patel', NULL),
(3, 'Rahul Sharma', 1),
(4, 'Vijay Shah', 1),
(5, 'Karan Mehta', 2);

SELECT
    p.partner_name,
    m.partner_name AS manager_name
FROM delivery_partners AS p
LEFT JOIN delivery_partners AS m
    ON p.manager_id = m.partner_id;
    
    
SELECT COUNT(*) AS total_rows
FROM delivery_partners AS p
LEFT JOIN delivery_partners AS m
    ON p.manager_id = m.partner_id;
 

 
/*2.
<p>Create tables `meal_types` (Veg, Jain, Diet) and `delivery_slots`(Lunch, Dinner) and write a CROSS JOIN that returns every meal type with every slot as a 6-row menu grid.
 Add it to `tiffin_advanced_joins.sql`. Constraint: Do not write any ON condition.</p>*/
 
 
 CREATE TABLE meal_types (
    meal_id INT PRIMARY KEY,
    meal_name VARCHAR(50));
    
    INSERT INTO meal_types (meal_id, meal_name)
VALUES
(1, 'Veg'),
(2, 'Jain'),
(3, 'Diet');
 
 CREATE TABLE delivery_slots (
    slot_id INT PRIMARY KEY,
    slot_name VARCHAR(50)
);

INSERT INTO delivery_slots (slot_id, slot_name)
VALUES
(1, 'Lunch'),
(2, 'Dinner');

SELECT
    m.meal_name,
    d.slot_name
FROM meal_types AS m
CROSS JOIN delivery_slots AS d;
 
 
 
/*3.
<p>Create `customer_feedback` (feedback_id, customer_id with no foreign key, rating 1 to 5) with 8 rows,
 of which 2 use a customer_id missing from `customers`. Write two queries, a LEFT JOIN and a RIGHT JOIN, that together list every unmatched row from both sides, 
 which is what FULL OUTER JOIN would return. Add them to `tiffin_advanced_joins.sql`. Constraint: Do not use UNION yet.</p>*/

CREATE TABLE customer_feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5)
);


INSERT INTO customer_feedback
(feedback_id, customer_id, rating)
VALUES
(1, 1, 5),
(2, 2, 4),
(3, 3, 5),
(4, 4, 3),
(5, 5, 4),
(6, 6, 5),
(7, 9, 2),
(8, 10, 1);

SELECT
    f.feedback_id,
    f.customer_id,
    f.rating
FROM customer_feedback AS f
LEFT JOIN customers AS c
    ON f.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
