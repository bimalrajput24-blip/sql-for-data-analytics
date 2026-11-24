 ##======================= session 12==============
  
  /*1.
<p>In `two_wheeler_db`, create `yearly_resales` (sale_year, brand, units_sold) with 21 rows,3 fictional brands for each year from 2019 to 2025, and units from 40 to 400.
 Save it in `two_wheeler_cte.sql`, together with a query that uses a WITH clause named `yearly_totals` to return total units_sold per year,
 sorted by year.</p>*/
 
 USE two_wheeler_db;

DROP TABLE IF EXISTS yearly_resales;

CREATE TABLE yearly_resales (
    sale_year INT NOT NULL,
    brand VARCHAR(50) NOT NULL,
    units_sold INT NOT NULL,
    PRIMARY KEY (sale_year, brand),
    CHECK (units_sold BETWEEN 40 AND 400)
);

INSERT INTO yearly_resales (sale_year, brand, units_sold) VALUES
(2019, 'RoadStar', 120),
(2019, 'MotoPeak', 85),
(2019, 'ThunderRide', 160),
(2020, 'RoadStar', 145),
(2020, 'MotoPeak', 95),
(2020, 'ThunderRide', 175),
(2021, 'RoadStar', 180),
(2021, 'MotoPeak', 130),
(2021, 'ThunderRide', 210),
(2022, 'RoadStar', 220),
(2022, 'MotoPeak', 165),
(2022, 'ThunderRide', 250),
(2023, 'RoadStar', 260),
(2023, 'MotoPeak', 190),
(2023, 'ThunderRide', 290),
(2024, 'RoadStar', 300),
(2024, 'MotoPeak', 230),
(2024, 'ThunderRide', 330),
(2025, 'RoadStar', 350),
(2025, 'MotoPeak', 275),
(2025, 'ThunderRide', 390);


WITH yearly_totals AS (
    SELECT
        sale_year,
        SUM(units_sold) AS total_units_sold
    FROM yearly_resales
    GROUP BY sale_year
)
SELECT
    sale_year,
    total_units_sold
FROM yearly_totals
ORDER BY sale_year;

 
 
 
/*2.
<p>Write a CTE-based query that uses the CTE `yearly_totals` twice, joining it to itself on `cur.sale_year = prev.sale_year + 1`, 
to return each year's units, the previous year's units and `yoy_growth_pct` rounded to 1 decimal. Add it to `two_wheeler_cte.sql`. The result must have 6 rows.</p>*/

WITH yearly_totals AS (
    SELECT
        sale_year,
        SUM(units_sold) AS total_units
    FROM yearly_resales
    GROUP BY sale_year
)
SELECT
    cur.sale_year,
    cur.total_units AS current_year_units,
    prev.total_units AS previous_year_units,
    ROUND(
        (cur.total_units - prev.total_units) * 100.0
        / prev.total_units,
        1
    ) AS yoy_growth_pct
FROM yearly_totals AS cur
JOIN yearly_totals AS prev
    ON cur.sale_year = prev.sale_year + 1
ORDER BY cur.sale_year;


/*3.
<p>Write a query with two CTEs, `brand_totals` (total units per brand) and `top_brand` 
(the brand with the most units, using ORDER BY and LIMIT 1), and join them to show the top brand and its share of all units as a percentage.
 Add it to `two_wheeler_cte.sql`.</p>*/
 
 
WITH brand_totals AS (
    SELECT
        brand,
        SUM(units_sold) AS total_units
    FROM yearly_resales
    GROUP BY brand
),
top_brand AS (
    SELECT
        brand,
        total_units
    FROM brand_totals
    ORDER BY total_units DESC
    LIMIT 1
)
SELECT
    tb.brand AS top_brand,
    tb.total_units,
    ROUND(
        tb.total_units * 100.0 /
        (SELECT SUM(units_sold) FROM yearly_resales),
        2
    ) AS share_of_all_units_pct
FROM top_brand AS tb;


 
 
/*4.
<p>Finish `two_wheeler_cte.sql` with a recursive CTE that builds a depreciation table for a bike priced at 80,000 rupees losing 12% value every year for 6 years,
 returning age_years and value_inr. The result must have 7 rows, starting at 80000.00.
 Hint: Use `CAST(80000 AS DECIMAL(10,2))` in the anchor row so decimals stay exact.</p>*/
 
 WITH RECURSIVE depreciation AS (
    SELECT
        0 AS age_years,
        CAST(80000 AS DECIMAL(10,2)) AS value_inr

    UNION ALL

    SELECT
        age_years + 1,
        CAST(value_inr * 0.88 AS DECIMAL(10,2))
    FROM depreciation
    WHERE age_years < 6
)
SELECT
    age_years,
    value_inr
FROM depreciation
ORDER BY age_years;