##============= Session-04 ===============


/*1.
Write an SQL query to find all restaurants in a table called Restaurants whose names end with 'Cafe' using the LIKE operator.*/
select * from restaurants;
select 
       SR_NO,
       NAME,
       Rating
from restaurants
where  NAME like '%Cafe';



/*2.
In a Flipkart-style Products table, use the BETWEEN operator to select all products with a price between 500 and 1500 rupees.*/

select * from products;
            
SELECT *
FROM Products
WHERE Price BETWEEN 500 AND 1500;



/*3.
Write an SQL query to display all users from a Users table whose city is either 'Ahmedabad', 'Surat', or 'Vadodara' using the IN operator.*/

select * from users;

select 
	  ID,
      Name,
      City,
      Followers
from users
where City in ("Ahmedabad" ,"Surat" or "Vadodara");




/*4.
Given a table called Songs with columns song_name and artist_name, find all songs where the artist_name contains the letter sequence 'ar' anywhere in the name using the LIKE
 operator.<br><br><em><strong>Hint:</strong> Use wildcards on both sides of the pattern.</em>*/
drop table songs;
create table Songs (
             Song_name varchar(100),
             Artist_name varchar(100));

insert into songs (Song_name, Artist_name)
value
      ('Believer', 'Imagine Dragons'),
      ('Roar', 'Katy Perry'),
      ('Memories', 'Maroon 5'),
      ('Hello', 'Adele'),
      ('Faded', 'Alan Walker');

select * from songs;

select * from songs
where Artist_name like "%ar%";

