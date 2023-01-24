use olist;
-- 1. From the order_items table, find the price of the highest priced order and lowest price order.
SELECT max(price), min(price) FROM olist.order_items;
-- 2. From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT max(shipping_limit_date), min(shipping_limit_date) FROM olist.order_items;
-- 3. From the customers table, find the states with the greatest number of customers.
SELECT DISTINCT customer_state, count(customer_id) from olist.customers
GROUP BY customer_state
ORDER BY count(customer_state) DESC
LIMIT 10;
-- 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
SELECT DISTINCT customer_city, count(customer_id) from olist.customers
WHERE customer_state= "SP"
GROUP BY customer_city
ORDER BY count(customer_id) DESC
LIMIT 1;
-- 5. From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT count(DISTINCT business_segment) AS number_segment FROM olist.closed_deals
WHERE business_segment is not null;
-- 33
-- 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment 
-- and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT business_segment, sum(declared_monthly_revenue) FROM olist.closed_deals
GROUP BY business_segment
ORDER BY sum(declared_monthly_revenue) DESC
LIMIT 3;
-- 7. From the order_reviews table, find the total number of distinct review score values.
SELECT count(DISTINCT review_score) FROM olist.order_reviews;
-- Answer : 5
-- 8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5, 
-- then find the review score and category occurring most frequently in the table.
ALTER TABLE order_reviews ADD description_review varchar(255);
UPDATE order_reviews
SET description_review = "very good"
WHERE review_score = 5;
UPDATE order_reviews
SET description_review = "good"
WHERE review_score = 4;
UPDATE order_reviews
SET description_review = "satisfying"
WHERE review_score = 3;
UPDATE order_reviews
SET description_review = "bad"
WHERE review_score = 2;
UPDATE order_reviews
SET description_review = "very bad"
WHERE review_score = 1;
SELECT DISTINCT description_review, count(description_review) from olist.order_reviews
GROUP BY description_review
ORDER BY count(description_review) DESC
LIMIT 1;
-- From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
SELECT review_score, count(review_score) FROM olist.order_reviews
GROUP BY review_score
ORDER BY count(review_score) DESC
LIMIT 1;