##============= Session-03 ===============

/*1.
Write an SQL query to select all restaurants from a table named 'restaurants' where the rating is greater than or equal to 4.5.*/

use restaurants;
select * from restaurants
where rating >= '4.5';



/*2.
In a table called 'movies', filter and display only the movies released after 2020 and with genre 'Action' using the WHERE clause and AND operator*/

select * from movies
where release_year > 2020 and genre = 'action' ;



/*3.
Given a table 'products' with columns (id, name, price, category), write a query to find all products not in the 'Electronics' category or with a price less than 500*/

CREATE TABLE products (
    id int,
    Name VARCHAR(100),
    price int,
    category VARCHAR(50)
);

select * from products;

insert into products (id,Name,price,category)
value
     (1, 'Laptop', 45000, 'Electronics'),
     (2, 'Mouse', 350, 'Electronics'),
     (3, 'Office Chair', 4500, 'Furniture'),
     (4, 'Notebook', 100, 'Stationery'),
     (5, 'Headphones', 1200, 'Electronics');

select * from products
where  not category = 'Electronics' or price <= 500;


/*4.
Write an SQL query for a table 'users' to show all users who are NOT from 'Ahmedabad' and have more than 1000 followers.<br><br><em><strong>Hint:</strong> 
Use the NOT operator combined with AND.</em> */

CREATE TABLE users (
    id INT,
    name VARCHAR(50),
    city VARCHAR(50),
    followers INT
);

insert into users(id,name,city,followers)
value
     (1, 'Rahul', 'Surat', 1500),
     (2, 'Priya', 'Ahmedabad', 2500),
     (3, 'Amit', 'Vadodara', 800),
     (4, 'Neha', 'Rajkot', 3000),
     (5, 'Karan', 'Ahmedabad', 500);

select * from users
where not city = 'Ahmedabad' and followers >= 1000;
