-- 09-SQL Homework
USE sakila;
show tables;

-- 1a. Display the first and last names of all actors from the table actor.
SELECT first_name,last_name FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
-- SELECT actor_id, first_name FROM actor WHERE first_name = 'Joe';
SELECT actor_id FROM actor WHERE first_name = 'Joe';

-- 2b. Find all actors whose last name contain the letters GEN:
SELECT * FROM actor WHERE last_name LIKE '%GEN%';

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT last_name,first_name FROM actor WHERE last_name LIKE '%LI%';

-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id,country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, 
-- so create a column in the table actor named description and use the data type BLOB (Make sure to research the type 
-- BLOB, as the difference between it and VARCHAR are significant).
ALTER TABLE actor
ADD COLUMN description BLOB;
desc actor;
-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description column.
ALTER TABLE actor
DROP COLUMN description;
DESC actor;

-- 4a. List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) FROM actor GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only for 
-- names that are shared by at least two actors
SELECT last_name, COUNT(*) FROM actor GROUP BY last_name HAVING COUNT(*) > 1;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
-- Write a query to fix the record.
-- REPLACE(first_name, 'GROUCHO', 'HARPO') FROM actor WHERE last_name ='WILLIAMS';
UPDATE actor SET first_name = REPLACE(first_name, 'GROUCHO', 'HARPO') WHERE first_name = 'GROUCHO' AND last_name ='WILLIAMS';
SELECT * FROM actor WHERE last_name ='WILLIAMS';

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct 
-- name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
-- SELECT * FROM actor WHERE first_name = 'HARPO'; 
-- Using WHERE because safe update mode (sql_safe_udates) is enabled
UPDATE actor SET first_name = REPLACE(first_name, 'HARPO', 'GROUCHO') WHERE last_name = 'WILLIAMS';
-- SELECT * FROM actor WHERE last_name = 'WILLIAMS';

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html

SHOW CREATE TABLE address;
-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name: