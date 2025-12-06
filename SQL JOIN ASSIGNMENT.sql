-- List all films and the languages they were produced in.

SELECT f.film_id, l.name
FROM film f
JOIN language l
ON l.language_id = f.language_id

--Show each customer's full name along with the city and country they live in---

SELECT CONCAT(c.first_name,' ', c.last_name) AS Full_name, co.country_id,
ci.city, co.country
FROM customer c
LEFT JOIN address a
ON c.customer_id = a.address_id
LEFT JOIN city ci
ON ci.city_id = a.city_id
LEFT JOIN country co
ON ci.country_id = co.country_id
ORDER BY Full_name ASC

--List all rentals with the customer name and the staff who handled the rental.

SELECT
CONCAT(c.first_name,' ', c.last_name) AS Customer_name, CONCAT(s.first_name,' ', s.last_name) 
AS Staff_name, r.rental_id
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN staff s
ON s.staff_id = r.staff_id


--For each film, list all the categories it belongs to.

SELECT f.title, c.name AS category
FROM film f
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id;

-- Show each customer and the total amount they have paid.

SELECT CONCAT(c.first_name,' ', c.last_name) AS customer_name, SUM(p.amount) AS Total_paid
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id
GROUP BY customer_name
ORDER BY Total_paid;

-- Show each film and the total number of times it has been rented.

SELECT COUNT(f.film_id) AS QTY, r.rental_id, f.title
FROM film f
JOIN rental r
ON f.film_id = f.film_id
GROUP BY f.title, r.rental_id
ORDER BY  QTY DESC;

--List all staff members and the store they work in, including the store’s address and city

SELECT* FROM store
SELECT CONCAT(s.first_name,' ', s.last_name) AS Staff_name, st.store_id, a.address, c.city
FROM store st
JOIN staff s
ON s.store_id = st.store_id
JOIN address a
ON st.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id;

--Display all films along with their actors’ full names.

SELECT  f.title, CONCAT(a.first_name,' ', a.last_name) AS Actor_name, fa.actor_id
FROM film_actor fa
JOIN actor a
ON a.actor_id = fa.actor_id
JOIN film f
ON f.film_id = fa.film_id;

-- Show each rental with the film title and customer details.

SELECT r.rental_id, f.title, CONCAT(c.first_name,' ', c.last_name) AS Customer_name
FROM rental r
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id
JOIN customer c 
ON r.customer_id = c.customer_id;

-- For each store, list how many films are available in its inventory.

SELECT s.store_id, f.title, i.inventory_id
FROM store s
JOIN inventory i 
ON i.store_id = i.store_id
JOIN film f
ON f.film_id = i.film_id;

--Display customers, their rentals, the corresponding film titles, and the countries where the customers live

SELECT CONCAT(c.first_name,' ', last_name) AS Customer_name, r.rental_id, f.title, co.country
FROM  customer c
JOIN rental r
ON c.customer_id = r.customer_id
JOIN inventory i 
ON i.inventory_id = r.inventory_id
JOIN film f
ON f.film_id = i.film_id
JOIN address a 
ON c.address_id = a.address_id
JOIN city ci 
ON a.city_id = ci.city_id
JOIN country co 
ON ci.country_id = co.country_id;

/*For each rental, show the rental date, film title, customer full name, and the amount the customer paid for
that rental.*/

SELECT r.rental_date, f.title, CONCAT(c.first_name,' ', last_name) AS Customer_name, SUM(p.amount) AS Amount_paid
FROM rental r
JOIN payment p
ON p.rental_id = r.rental_id
JOIN customer c
ON c.customer_id = p.customer_id
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id 
GROUP BY rental_date, Customer_name,  f.title
ORDER BY Amount_paid DESC

/*Show each store, the number of films in its inventory, the store address, and the city the store is located
in.*/

SELECT s.store_id, f.title, i.inventory_id, a.address, c.city
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN store s
ON s.store_id = i.store_id
JOIN address a
ON a.address_id = s.address_id
JOIN city c
ON a.city_id = c.city_id

/*For each film rented, display the film title, the category name, the customer who rented it, and the staff
who handled the rental*/

SELECT  r.rental_id, f.title, CONCAT (cu.first_name,' ', cu.last_name) AS Customer_name, 
CONCAT(s.first_name,' ', s.last_name) AS Staff_name
FROM rental r
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category ca
ON fc.category_id = ca.category_id
JOIN customer cu 
ON r.customer_id = cu.customer_id
JOIN staff s 
ON r.staff_id = s.staff_id;



