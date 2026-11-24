
##======================= session 19==============


/*1.<p>In `society_energy_db`, create `meter_readings_big` (reading_id primary key, flat_no, reading_date DATE, units_kwh INT) and fill it with 100,000 rows using a recursive CTE inside an INSERT, in `society_indexing.sql`.
 Use 200 flats (wings A to D, numbers 101 to 150) and dates spread over 2024 and 2025.
 Hint: Run `SET SESSION cte_max_recursion_depth = 100000;` first, use `INSERT INTO t WITH RECURSIVE ... SELECT ...`,
 and build flat_no from `MOD(n,200) DIV 50` and `101 + MOD(n,50)`.</p>*/
 
 
 USE society_energy_db;

SET SESSION cte_max_recursion_depth = 100000;

DROP TABLE IF EXISTS meter_readings_big;

CREATE TABLE meter_readings_big (
    reading_id INT PRIMARY KEY,
    flat_no VARCHAR(6) NOT NULL,
    reading_date DATE NOT NULL,
    units_kwh INT NOT NULL
);

INSERT INTO meter_readings_big (reading_id, flat_no, reading_date, units_kwh)
WITH RECURSIVE seq (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 100000
)
SELECT
    n AS reading_id,
    CONCAT(
        CHAR(65 + (MOD(n, 200) DIV 50)),
        '-',
        101 + MOD(n, 50)
    ) AS flat_no,
    DATE_ADD('2024-01-01', INTERVAL MOD(n - 1, 731) DAY) AS reading_date,
    80 + MOD(n * 17, 220) AS units_kwh
FROM seq;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT flat_no) AS distinct_flats,
    MIN(reading_date) AS first_reading_date,
    MAX(reading_date) AS last_reading_date
FROM meter_readings_big;

SELECT flat_no, COUNT(*) AS reading_count
FROM meter_readings_big
GROUP BY flat_no
ORDER BY flat_no;

 
/*2.
<p>Write the lookup query `SELECT * FROM meter_readings_big WHERE flat_no = 'B-107';` in `society_indexing.sql`,
 run EXPLAIN on it before any index exists, and add a comment with the `type`, `key` and `rows` values you see.
 The comment must show a full table scan with about 100,000 rows.</p>*/
 
 -- Lookup before creating any index.
SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';

-- Check execution plan.
EXPLAIN
SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';

-- Expected pre-index execution plan:
-- type = ALL
-- key  = NULL
-- rows ~= 100000
-- Full table scan.
 

 
/*3.
<p>Create an index `idx_flat_no` on flat_no in `society_indexing.sql`, run EXPLAIN on the same lookup query again,
 and add a comment with the new `type`, `key` and `rows`. The scanned rows must drop from about 100,000 to about 500.
 Hint: Use `CREATE INDEX idx_flat_no ON meter_readings_big (flat_no);`.</p>*/
 
CREATE INDEX idx_flat_no
ON meter_readings_big (flat_no);

EXPLAIN
SELECT *
FROM meter_readings_big
WHERE flat_no = 'B-107';

-- Expected post-index execution plan:
-- type = ref
-- key  = idx_flat_no
-- rows ~= 500
 
 
 
/*4.
<p>Finish `society_indexing.sql` with two queries for October 2025 readings: one using `WHERE YEAR(reading_date)
 = 2025 AND MONTH(reading_date) = 10`, and one using `reading_date >= '2025-10-01' AND reading_date < '2025-11-01'` 
 after you create `idx_reading_date`. Run EXPLAIN on both and add a comment with the `rows` and `key` of each. Check that only the second query uses the index.</p>*/
 
 CREATE INDEX idx_reading_date
ON meter_readings_big (reading_date);

SELECT *
FROM meter_readings_big
WHERE YEAR(reading_date) = 2025
  AND MONTH(reading_date) = 10;
  
  SELECT *
FROM meter_readings_big
WHERE reading_date >= '2025-10-01'
  AND reading_date < '2025-11-01';