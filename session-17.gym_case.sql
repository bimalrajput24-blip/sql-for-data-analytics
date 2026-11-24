##======================= session 17==============



/*1.
<p>Create `gym_activity` (member_id, visits_last_30_days INT, monthly_fee_inr INT) in `gym_membership_db` and insert one row for each of your 15 `members`, with visits from 0 to 28 and fees from 800 to 2,500, in `gym_case.sql`.
 Make sure at least 3 members have fewer than 4 visits and at least 3 have 16 or more.</p>*/
 
 
USE gym_membership_db;

CREATE TABLE gym_activity (
    member_id INT PRIMARY KEY,
    visits_last_30_days INT,
    monthly_fee_inr INT,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO gym_activity
(member_id, visits_last_30_days, monthly_fee_inr)
VALUES
(1,  2,  800),
(2,  5,  1200),
(3,  18, 1800),
(4,  22, 2500),
(5,  1,  900),
(6,  12, 1500),
(7,  20, 2200),
(8,  3,  1000),
(9,  16, 2000),
(10, 8,  1300),
(11, 25, 2500),
(12, 0,  800),
(13, 14, 1700),
(14, 19, 2300),
(15, 28, 2400);

SELECT * FROM gym_activity;

SELECT COUNT(*) AS total_members
FROM gym_activity;

SELECT *
FROM gym_activity
WHERE visits_last_30_days < 4;

SELECT *
FROM gym_activity
WHERE visits_last_30_days >= 16;
 
 
/*2.
<p>Write a query in `gym_case.sql` that returns member_id and `engagement` using CASE WHEN:
 'Regular' for 16 or more visits, 'Occasional' for 8 to 15, and 'Dormant' otherwise. The result must have 15 rows. Hint: Conditions are checked in order, 
 so test the highest threshold first.</p>*/
 

SELECT
    member_id,
    CASE
        WHEN visits_last_30_days >= 16 THEN 'Regular'
        WHEN visits_last_30_days BETWEEN 8 AND 15 THEN 'Occasional'
        ELSE 'Dormant'
    END AS engagement
FROM gym_activity
ORDER BY member_id;
 
 
/*3.
<p>Write a query that bins monthly_fee_inr into 'Basic' (under 1,200), 'Standard' (1,200 to 1,799) and 'Premium' (1,800 and above),
 and shows the number of members and total fees per bin using GROUP BY. Add it to `gym_case.sql`. The total of the counts must equal 15.</p>*/
 
 SELECT
    CASE
        WHEN monthly_fee_inr < 1200 THEN 'Basic'
        WHEN monthly_fee_inr BETWEEN 1200 AND 1799 THEN 'Standard'
        ELSE 'Premium'
    END AS fee_category,
    COUNT(member_id) AS total_members,
    SUM(monthly_fee_inr) AS total_fees
FROM gym_activity
GROUP BY
    CASE
        WHEN monthly_fee_inr < 1200 THEN 'Basic'
        WHEN monthly_fee_inr BETWEEN 1200 AND 1799 THEN 'Standard'
        ELSE 'Premium'
    END
ORDER BY
    CASE fee_category
        WHEN 'Basic' THEN 1
        WHEN 'Standard' THEN 2
        WHEN 'Premium' THEN 3
    END;
 
 
/*4.
<p>Finish `gym_case.sql` with a query joining `members` and `gym_activity` that returns member_name and `risk_label` using CASE WHEN:
 'Churn Risk' below 4 visits, 'Watch' below 8, 'Healthy' otherwise, sorted by visits ascending. Run the whole file and confirm each label appears at least once.</p>*/
 
 
SELECT
    m.member_name,
    CASE
        WHEN ga.visits_last_30_days < 4 THEN 'Churn Risk'
        WHEN ga.visits_last_30_days < 8 THEN 'Watch'
        ELSE 'Healthy'
    END AS risk_label
FROM members m
JOIN gym_activity ga
    ON m.member_id = ga.member_id
ORDER BY ga.visits_last_30_days ASC;

 
 
 
 
 
