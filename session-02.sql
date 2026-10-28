##============= Session-02 ===============

/* 1. Open your SQL editor and run a query to select all columns from a table named restaurants using SELECT * FROM restaurants, */

CREATE DATABASE IF NOT EXISTS restaurants;

use restaurants;

CREATE TABLE restaurants(
SR_NO INT,
Resturants_NAME varchar(20),
Rating int
);

drop table restaurants;
select * from restaurants;
select * from restaurants;

/*2.
Write an SQL query to display only the name and rating columns from the table zomato_reviews.*/
drop table zometo_reviews;
create table zomato_reviews(
SR_NO INT, NAME VARCHAR(20), Rating int);

SELECT SR_NO,Resturants_NAME,Rating from restaurants;
insert into restaurants
value (1,"Momscafe",'4'),
	  (2,"AHAAR","5"),
	  (3,"Happyness","3");
      
SELECT name, rating
FROM zomato_reviews;

/*3.
Write an SQL query to select the movie_name and release_year columns from a table called movies, but rename movie_name as 'Title' and release_year as 'Year Released' in
 the output using the AS keyword*/

create table movies(
SR_NO INT,movie_NAME VARCHAR(20), release_year date);

SELECT SR_NO,movie_NAME,release_year from movies;
insert into movies
value (1,"Inception",'2014-05-02'),
	  (2,"Batman","2012-08-15"),
	  (3,"Ironman","2008-12-05");
      
select 
	movie_NAME as title,
	release_year AS Year_release
from movies;    
        
/* 4.
In a table called products, write an SQL query that selects all columns and add a comment in your SQL code explaining what the query does.<br><br><em><strong>Hint:</strong> 
Use -- to write a single-line comment above your query.</em>


select * from products;

/*== here select * reprecent all colunms selected and for table we used from products==*/

