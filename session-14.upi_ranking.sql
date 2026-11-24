##======================= session 14==============

/*1.
<p>Open your `payments` table in `upi_payments_db` and write a query in `upi_ranking.sql` that numbers each 
sender_handle's payments from newest to oldest with ROW_NUMBER, as `payment_no`.
 Hint: If you missed the last session, create `payments` with at least 12 rows and a repeated amount in one category first.</p>*/
 
 USE upi_payments_db;

SELECT
    payment_id,
    sender_handle,
    merchant_category,
    amount_inr,
    paid_on,
    ROW_NUMBER() OVER (
        PARTITION BY sender_handle
        ORDER BY paid_on DESC, payment_id DESC
    ) AS payment_no
FROM payments
ORDER BY sender_handle, payment_no;
 

 
/*2.
<p>Write a query that ranks payments by amount_inr within each merchant_category,
 showing both RANK and DENSE_RANK as separate columns. Add it to `upi_ranking.sql`.
 The result must contain at least one tie, where RANK skips a number and DENSE_RANK does not.</p>*/
 
 SELECT
    payment_id,
    sender_handle,
    merchant_category,
    amount_inr,

    RANK() OVER (
        PARTITION BY merchant_category
        ORDER BY amount_inr DESC
    ) AS payment_rank,

    DENSE_RANK() OVER (
        PARTITION BY merchant_category
        ORDER BY amount_inr DESC
    ) AS dense_payment_rank

FROM payments
ORDER BY merchant_category, amount_inr DESC;

SELECT
    merchant_category,
    amount_inr,
    COUNT(*) AS total_payments
FROM payments
GROUP BY merchant_category, amount_inr
HAVING COUNT(*) > 1;

 
/*3.
<p>Write a query using a CTE and ROW_NUMBER that returns only the latest payment of each sender_handle, with sender_handle, paid_on and amount_inr.
 Add it to `upi_ranking.sql`. The result must have exactly 6 rows. Hint: Filter on the row number in the outer query, because window functions cannot be used in WHERE.</p>*/
 
 WITH latest_payments AS (
    SELECT
        sender_handle,
        paid_on,
        amount_inr,
        ROW_NUMBER() OVER (
            PARTITION BY sender_handle
            ORDER BY paid_on DESC, payment_id DESC
        ) AS rn
    FROM payments
)

SELECT
    sender_handle,
    paid_on,
    amount_inr
FROM latest_payments
WHERE rn = 1
ORDER BY sender_handle;

SELECT COUNT(*) AS total_rows
FROM (
    SELECT sender_handle
    FROM payments
    GROUP BY sender_handle
) AS sender_count;
 

 
/*4.
<p>Finish `upi_ranking.sql` with a query that returns the top 2 largest amount_inr values in each merchant_category using DENSE_RANK in a CTE, keeping ties.
 Run the whole file and confirm that every category appears and the tied payments are both included.</p>*/
 
 WITH category_rankings AS (
    SELECT
        payment_id,
        sender_handle,
        merchant_category,
        amount_inr,
        paid_on,
        DENSE_RANK() OVER (
            PARTITION BY merchant_category
            ORDER BY amount_inr DESC
        ) AS amount_rank
    FROM payments
)

SELECT
    payment_id,
    sender_handle,
    merchant_category,
    amount_inr,
    paid_on,
    amount_rank
FROM category_rankings
WHERE amount_rank <= 2
ORDER BY merchant_category, amount_rank, amount_inr DESC;

SELECT
    merchant_category,
    COUNT(*) AS returned_payments,
    MAX(amount_inr) AS highest_amount
FROM (
    SELECT
        merchant_category,
        amount_inr,
        DENSE_RANK() OVER (
            PARTITION BY merchant_category
            ORDER BY amount_inr DESC
        ) AS amount_rank
    FROM payments
) AS ranked_payments
WHERE amount_rank <= 2
GROUP BY merchant_category
ORDER BY merchant_category;

WITH category_rankings AS (
    SELECT
        payment_id,
        sender_handle,
        merchant_category,
        amount_inr,
        DENSE_RANK() OVER (
            PARTITION BY merchant_category
            ORDER BY amount_inr DESC
        ) AS amount_rank
    FROM payments
)
SELECT *
FROM category_rankings
WHERE amount_rank <= 2
ORDER BY merchant_category, amount_rank;
 
 
 
 
