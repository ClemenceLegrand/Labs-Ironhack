-- LAB MYSQL Analytical functions

-- 1. find the running total of rental payments for each customer in the payment table, ordered by payment date. 
-- By selecting the customer_id, payment_date, and amount columns from the payment table, and then applying the SUM function to the amount column within each customer_id partition, ordering by payment_date.

use sakila;
SELECT customer_id, payment_date, amount, SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)  as running_total
FROM payment;

-- 2.  find the rank and dense rank of each payment amount within each payment date by selecting the payment_date and amount columns from the payment table, 
-- and then applying the RANK and DENSE_RANK functions to the amount column within each payment_date partition, ordering by amount in descending order.

SELECT DATE(payment_date) FROM payment; -- it works to extract only the date from datetime
SELECT payment_id, 
	DATE (payment_date), 
    amount, 
    RANK() OVER (PARTITION BY DATE (payment_date) ORDER BY amount DESC) AS rnk,
    DENSE_RANK() OVER (PARTITION BY DATE (payment_date) ORDER BY amount DESC) AS dense_rnk
FROM payment;

-- 3. find the ranking of each film based on its rental rate, within its respective category. 

SELECT category.name, 
	film.title as film_title, 
    film.rental_rate,
	RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC) AS rnk, 
    DENSE_RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC) AS dense_rnk
FROM film INNER JOIN  film_category ON film.film_id = film_category.film_id
	INNER JOIN category ON film_category.category_id = category.category_id
ORDER BY category.name, rental_rate DESC, film_title;

-- 4.(OPTIONAL) update the previous query from above to retrieve only the top 5 films within each category

SELECT * FROM 
	(
    SELECT category.name, 
		film.title as film_title, 
		film.rental_rate,
		DENSE_RANK() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC, film.title) AS dense_rnk,
        ROW_NUMBER() OVER (PARTITION BY category.name ORDER BY film.rental_rate DESC,film.title) AS row_num
	FROM film INNER JOIN  film_category ON film.film_id = film_category.film_id
		INNER JOIN category ON film_category.category_id = category.category_id
	ORDER BY category.name, rental_rate DESC, row_num
    ) as sub_table
WHERE row_num <=5;

-- 5. find the difference between the current and previous payment amount 
-- and the difference between the current and next payment amount, for each customer in the payment table

SELECT customer_id, payment_date, amount,
(amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)) AS diff_prev,
(LEAD(amount)  OVER (PARTITION BY customer_id ORDER BY payment_date) - amount) AS diff_next
FROM payment
ORDER BY customer_id;
    

    