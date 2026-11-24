##======================= session 18==============




/*1.
<p>Create a database `society_energy_db` and a table `meter_readings` (reading_id primary key, flat_no, wing, reading_date DATE, units_kwh INT, rate_per_unit DECIMAL(4,2)) in `society_views.sql`. Insert 36 rows for 12 flats in wings A, B and C of a fictional housing society,
 with one reading each in July, August and September 2026, units from 90 to 450 and rates of 5.50 to 7.50.</p>*/
 
 CREATE DATABASE IF NOT EXISTS society_energy_db;
 
USE society_energy_db;

DROP TABLE IF EXISTS meter_readings;

CREATE TABLE meter_readings (
    reading_id INT PRIMARY KEY,
    flat_no VARCHAR(10) NOT NULL,
    wing CHAR(1) NOT NULL,
    reading_date DATE NOT NULL,
    units_kwh INT NOT NULL,
    rate_per_unit DECIMAL(4,2) NOT NULL
);

INSERT INTO meter_readings
    (reading_id, flat_no, wing, reading_date, units_kwh, rate_per_unit)
VALUES
    
    (1,  'A-101', 'A', '2026-07-31', 120, 5.50),
    (2,  'A-102', 'A', '2026-07-31', 185, 6.00),
    (3,  'A-103', 'A', '2026-07-31', 240, 6.50),
    (4,  'A-104', 'A', '2026-07-31', 310, 7.00),

    
    (5,  'B-201', 'B', '2026-07-31',  95, 5.75),
    (6,  'B-202', 'B', '2026-07-31', 160, 6.25),
    (7,  'B-203', 'B', '2026-07-31', 275, 6.75),
    (8,  'B-204', 'B', '2026-07-31', 390, 7.50),

    
    (9,  'C-301', 'C', '2026-07-31', 140, 5.50),
    (10, 'C-302', 'C', '2026-07-31', 210, 6.00),
    (11, 'C-303', 'C', '2026-07-31', 335, 7.00),
    (12, 'C-304', 'C', '2026-07-31', 450, 7.50),

    
    (13, 'A-101', 'A', '2026-08-31', 130, 5.50),
    (14, 'A-102', 'A', '2026-08-31', 195, 6.00),
    (15, 'A-103', 'A', '2026-08-31', 250, 6.50),
    (16, 'A-104', 'A', '2026-08-31', 320, 7.00),
    (17, 'B-201', 'B', '2026-08-31', 105, 5.75),
    (18, 'B-202', 'B', '2026-08-31', 170, 6.25),
    (19, 'B-203', 'B', '2026-08-31', 285, 6.75),
    (20, 'B-204', 'B', '2026-08-31', 400, 7.50),
    (21, 'C-301', 'C', '2026-08-31', 150, 5.50),
    (22, 'C-302', 'C', '2026-08-31', 220, 6.00),
    (23, 'C-303', 'C', '2026-08-31', 345, 7.00),
    (24, 'C-304', 'C', '2026-08-31', 440, 7.50),


    (25, 'A-101', 'A', '2026-09-30', 125, 5.50),
    (26, 'A-102', 'A', '2026-09-30', 200, 6.00),
    (27, 'A-103', 'A', '2026-09-30', 260, 6.50),
    (28, 'A-104', 'A', '2026-09-30', 330, 7.00),
    (29, 'B-201', 'B', '2026-09-30', 110, 5.75),
    (30, 'B-202', 'B', '2026-09-30', 180, 6.25),
    (31, 'B-203', 'B', '2026-09-30', 295, 6.75),
    (32, 'B-204', 'B', '2026-09-30', 410, 7.50),
    (33, 'C-301', 'C', '2026-09-30', 160, 5.50),
    (34, 'C-302', 'C', '2026-09-30', 230, 6.00),
    (35, 'C-303', 'C', '2026-09-30', 355, 7.00),
    (36, 'C-304', 'C', '2026-09-30', 450, 7.50);

SELECT * FROM meter_readings
ORDER BY wing, flat_no, reading_date;
 
 
 
/*2.
<p>Create a view `v_monthly_flat_bill` in `society_views.sql` that returns flat_no, wing, 
`bill_month` (using MONTH), units_kwh and `bill_amount_inr` (units multiplied by rate, rounded to 2 decimals). Then run `SELECT * FROM v_monthly_flat_bill;` to 
confirm 36 rows. Hint: Use `CREATE OR REPLACE VIEW` so the file can be re-run.</p>*/

CREATE OR REPLACE VIEW v_monthly_flat_bill AS
SELECT
    flat_no,
    wing,
    MONTH(reading_date) AS bill_month,
    units_kwh,
    ROUND(units_kwh * rate_per_unit, 2) AS bill_amount_inr
FROM meter_readings;

SELECT * FROM v_monthly_flat_bill
ORDER BY wing, flat_no, bill_month;

SELECT COUNT(*) AS total_records
FROM meter_readings;

SELECT * FROM v_monthly_flat_bill;


/*3.
<p>Create a simple view `v_wing_a_readings` showing the columns of `meter_readings` for wing A only, then run an
 UPDATE through the view to correct one flat's units_kwh, and check the change in the base table. Add it to `society_views.sql`. 
 Hint: Views with GROUP BY or aggregates cannot be updated.</p>*/
 
 CREATE OR REPLACE VIEW v_wing_a_readings AS
SELECT
    reading_id,
    flat_no,
    wing,
    reading_date,
    units_kwh,
    rate_per_unit
FROM meter_readings
WHERE wing = 'A';

UPDATE v_wing_a_readings
SET units_kwh = 125
WHERE reading_id = 1;

SELECT *
FROM meter_readings
WHERE reading_id = 1;

 
 
/*4.
<p>Finish `society_views.sql` with a dashboard view `v_wing_summary` returning wing, total units and average bill per wing using GROUP BY,
 then add a commented-out UPDATE on it that fails, with the MySQL error code as a comment. Run the file from a clean database and confirm all 
 three views exist with `SHOW FULL TABLES WHERE Table_type = 'VIEW';`.</p>*/
 
 CREATE OR REPLACE VIEW v_wing_summary AS
SELECT
    wing,
    SUM(units_kwh) AS total_units_kwh,
    ROUND(AVG(units_kwh * rate_per_unit), 2)
        AS average_bill_inr
FROM meter_readings
GROUP BY wing;

-- MySQL Error 1288: Target table is not updatable.
-- UPDATE v_wing_summary
-- SET total_units_kwh = 999
-- WHERE wing = 'A';

SHOW FULL TABLES
WHERE Table_type = 'VIEW';
