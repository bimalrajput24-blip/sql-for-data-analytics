##============= Session-05 ===============


/*1.
Write an SQL query using the DISTINCT keyword to find all unique payment methods used in the orders table of a food delivery app database.*/

use restaurants;

create table orders (
		  Order_id INT ,
          Customer_name VARCHAR(100),
		  Restaurant_name VARCHAR(100),
          amount int,
          payment_method VARCHAR(50));
          
insert into orders(Order_id,Customer_name, restaurant_name, amount, payment_method)
value 
     (1, 'Rahul', 'Pizza Hub', 450, 'UPI'),
     (2, 'Priya', 'Burger Point', 250, 'Cash'),
     (3, 'Amit', 'Food Palace', 600, 'Credit Card'),
	 (4, 'Neha', 'Pizza Hub', 350, 'UPI'),
     (5, 'Karan', 'Spice Garden', 500, 'Debit Card');
     
 select distinct payment_method
 from orders;


/*2.
Query the users table to list all cities where users have registered, but display each city only once and sort the result in alphabetical order (A-Z).*/

select * from users;
select distinct city
from users
order by city asc;


/*3.
Write an SQL query to select the top 5 most recent movie bookings from the bookings table, ordered by booking_date in descending order.*/

create table bookings (
               Booking_id int,
               customer_name varchar(60),
               Movie_name varchar(60),
               booking_date date);

insert into bookings ( Booking_id, customer_name, Movie_name, booking_date)
value 
     (1, 'Rahul', 'Jawan', '2026-10-20'),
     (2, 'Priya', 'Pathaan', '2026-10-25'),
     (3, 'Amit', 'Animal', '2026-10-18'),
     (4, 'Neha', 'Stree 2', '2026-10-28'),
     (5, 'Karan', 'Pushpa 2', '2026-10-22');
     
 select 
       *
 from bookings
 order by booking_date desc
 limit 5;




/*4.
From a products table containing Flipkart-style product data (id, name, category, sold_count), write an SQL query to retrieve the 10 products with the highest sold_count, displaying only product name and sold_count, sorted from highest to lowest.<br><br><em><strong>Hint:</strong>
 Use ORDER BY and LIMIT together to achieve this.</em>*/
 
 use restaurants;
 
 select * from products
order by sold_count desc
limit 5;
