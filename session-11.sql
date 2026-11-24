  ##======================= session 11==============
  
 /*1 <p>Create a database `two_wheeler_db` and a table `listings` (listing_id primary key, brand, model, year, kms_driven, price_inr, city) in `two_wheeler_subqueries.sql`. 
  Insert 20 used two-wheeler listings with 4 fictional brand names you invent, years 2016 to 2024, prices from 20,000 to 150,000 
  and 5 cities. Make the cheapest listing share its brand and year with at least one other listing.</p>*/
  
  CREATE DATABASE IF NOT EXISTS two_wheeler_db;


USE two_wheeler_db;

CREATE TABLE IF NOT EXISTS listings (
    listing_id INT PRIMARY KEY,
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    kms_driven INT,
    price_inr INT,
    city VARCHAR(50)
);

INSERT INTO listings
(listing_id, brand, model, year, kms_driven, price_inr, city)
VALUES
(1, 'Zentora', 'Spark 110', 2018, 32000, 25000, 'Surat'),
(2, 'Zentora', 'Spark 125', 2018, 28000, 45000, 'Ahmedabad'),
(3, 'Veltrix', 'Cruze 150', 2020, 18000, 75000, 'Mumbai'),
(4, 'Motrix', 'Flash 100', 2017, 45000, 30000, 'Pune'),
(5, 'Aerovex', 'Storm 160', 2022, 12000, 110000, 'Delhi'),
(6, 'Zentora', 'Spark 110 Pro', 2019, 25000, 40000, 'Surat'),
(7, 'Veltrix', 'Cruze 125', 2016, 55000, 20000, 'Ahmedabad'),
(8, 'Motrix', 'Flash 125', 2021, 15000, 65000, 'Mumbai'),
(9, 'Aerovex', 'Storm 200', 2023, 8000, 145000, 'Pune'),
(10, 'Zentora', 'Speed 150', 2020, 22000, 60000, 'Delhi');

SELECT * FROM listings;

SELECT COUNT(*) AS total_listings
FROM listings;

SELECT *
FROM listings
ORDER BY price_inr ASC
LIMIT 1;
  
  
  
/*2.
<p>Write a query in `two_wheeler_subqueries.sql` that returns listings priced above the overall average price, adding a column `gap_from_avg_inr` (price minus the average) with
 a scalar subquery in SELECT and the average used again in WHERE. Hint: Put the subquery in parentheses, for example `(SELECT AVG(price_inr) FROM listings)`.</p>*/
 
 
 SELECT
    listing_id,
    brand,
    model,
    year,
    kms_driven,
    price_inr,
    city,
    price_inr - (SELECT AVG(price_inr) FROM listings)
        AS gap_from_avg_inr
FROM listings
WHERE price_inr > (SELECT AVG(price_inr) FROM listings)
ORDER BY price_inr DESC;


 
/*3.
 <p>Write a query that finds all listings with the same brand and year as the cheapest listing, using a row subquery such as `WHERE (brand, year) = (SELECT ...)`.
 Add it to `two_wheeler_subqueries.sql`. The result must have at least 2 rows. Hint: The inner query needs `ORDER BY price_inr LIMIT 1`.</p>*/
 
 
 SELECT
    listing_id,
    brand,
    model,
    year,
    kms_driven,
    price_inr,
    city
FROM listings
WHERE (brand, year) = (
    SELECT brand, year
    FROM listings
    ORDER BY price_inr ASC
    LIMIT 1
)
ORDER BY price_inr ASC;
 

 
/*4.
<p>Finish `two_wheeler_subqueries.sql` with a query that uses a derived table in FROM to compute the average price per brand (rounded) and returns only 
brands whose average is above the overall average price. Give the derived table an alias. Run the whole file and confirm at least 1 brand is returned.</p>*/

SELECT
    brand,
    avg_brand_price
FROM (
    SELECT
        brand,
        ROUND(AVG(price_inr), 2) AS avg_brand_price
    FROM listings
    GROUP BY brand
) AS brand_averages
WHERE avg_brand_price > (
    SELECT AVG(price_inr)
    FROM listings
)
ORDER BY avg_brand_price DESC;

SELECT COUNT(*) AS total_listings
FROM listings;


SELECT COUNT(*) AS brands_above_average
FROM (
    SELECT brand
    FROM listings
    GROUP BY brand
    HAVING AVG(price_inr) > (
        SELECT AVG(price_inr)
        FROM listings
    )
) AS result;
