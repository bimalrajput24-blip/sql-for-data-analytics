/*1.
Write an SQL query using the SUM() function to calculate the total amount spent by users on food orders in a table food_orders 
(columns: order_id, user_id, amount) — imagine it's like Zomato's order history.*/

use restaurants;

CREATE TABLE food_orders (
    order_id INT,
    user_id INT,
    amount INT
);

INSERT INTO food_orders (order_id, user_id, amount)
VALUES
    (1, 101, 450),
    (2, 102, 250),
    (3, 103, 600),
    (4, 101, 350),
    (5, 102, 500);
    
    
SELECT * FROM food_orders;

SELECT SUM(amount) AS Total_Amount
FROM food_orders;





/*2.
Using the COUNT() function, find out how many songs a user has added to their playlist in a table spotify_playlists (columns: playlist_id, user_id, song_id).*/

CREATE TABLE spotify_playlists (
    playlist_id INT,
    user_id INT,
    song_id INT
);

INSERT INTO spotify_playlists
(playlist_id, user_id, song_id)
VALUES
(1, 101, 501),
(2, 101, 502),
(3, 101, 503),
(4, 102, 504),
(5, 102, 505);

SELECT * FROM spotify_playlists;

SELECT COUNT(song_id) AS Total_Songs
FROM spotify_playlists;


/*3.
Write an SQL query to get the average rating given to a movie in a table bookmyshow_reviews (columns: review_id, movie_id, rating), 
and round the result to 1 decimal place using the ROUND() function.<br><br><em><strong>Hint:</strong> Use AVG() with ROUND() to format the output.</em>*/

CREATE TABLE bookmyshow_reviews (
    review_id INT,
    movie_id INT,
    rating DECIMAL(3,1)
);

INSERT INTO bookmyshow_reviews
(review_id, movie_id, rating)
VALUES
(1, 101, 4.5),
(2, 102, 3.8),
(3, 101, 5.0),
(4, 103, 4.2),
(5, 102, 3.5);

SELECT * FROM bookmyshow_reviews;

SELECT
    ROUND(AVG(rating), 1) AS Average_Rating
FROM bookmyshow_reviews;


/*4.
Find the minimum and maximum transaction values for a user from a table paytm_transactions
 (columns: txn_id, user_id, amount) — show both the smallest and largest transaction amounts.*/
 
 CREATE TABLE paytm_transactions (
    txn_id INT,
    user_id INT,
    amount DECIMAL(10,2)
);
 
 INSERT INTO paytm_transactions
(txn_id, user_id, amount)
VALUES
(1, 101, 500),
(2, 101, 1200),
(3, 102, 300),
(4, 102, 2500),
(5, 103, 800);
 
 select * from paytm_transactions;
 
 SELECT
    MIN(amount) AS Minimum_Transaction,
    MAX(amount) AS Maximum_Transaction
FROM paytm_transactions;
 
 
/*5.Given a table myntra_orders (columns: order_id, user_id, total_price), write an SQL query to display the total number of orders, the average order value (rounded to 2 decimals),
 and the highest order value for each user_id.<br><br><em><strong>Constraint:</strong> Use GROUP BY to get results per user.</em>*/
 
 CREATE TABLE myntra_orders (
    order_id INT,
    user_id INT,
    total_price DECIMAL(10,2)
);

INSERT INTO myntra_orders
(order_id, user_id, total_price)
VALUES
(1, 101, 2500),
(2, 101, 4500),
(3, 102, 1200),
(4, 102, 3500),
(5, 103, 5000);

SELECT * FROM myntra_orders;

SELECT
    user_id,
    COUNT(order_id) AS Total_Orders,
    ROUND(AVG(total_price), 2) AS Average_Order_Value,
    MAX(total_price) AS Highest_Order_Value
FROM myntra_orders
GROUP BY user_id;
