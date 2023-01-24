create schema ironhack_examples;
use ironhack_examples;

Select * from ironhack_examples.applestore;
-- 1. What are the different genres?
SELECT DISTINCT prime_genre FROM ironhack_examples.applestore;
-- 2. Which is the genre with the most apps rated? result is Games
SELECT prime_genre, sum(rating_count_tot) FROM ironhack_examples.applestore 
GROUP BY prime_genre
ORDER BY sum(rating_count_tot) DESC
LIMIT 1;
-- 3. Which is the genre with most apps? Games 169
SELECT prime_genre, count(id_1) FROM ironhack_examples.applestore
GROUP BY prime_genre
ORDER BY count(id_1) DESC
LIMIT 1;
-- 4. Which is the one with least? Medical 1
SELECT prime_genre, count(id_1) FROM ironhack_examples.applestore
GROUP BY prime_genre
ORDER BY count(id_1) ASC
LIMIT 1;
-- 5. Find the top 10 apps most rated. 
SELECT track_name, rating_count_tot FROM ironhack_examples.applestore
ORDER BY rating_count_tot DESC
LIMIT 10;
-- 6. Find the top 10 apps best rated by users.
SELECT track_name, user_rating FROM ironhack_examples.applestore
ORDER BY user_rating DESC
LIMIT 10;
-- 7. Take a look at the data you retrieved in question 5. Give some insights. This is very famous application, for the most it is social networks or game apps.  
-- 8. Take a look at the data you retrieved in question 6. Give some insights. The best rated by users apps are not the most famous. They all have 5 points. It seems to be games for the most. 
-- 9. Now compare the data from questions 5 and 6. What do you see? The most rated apps are not the best rated app. More there are users, mor it is difficult to have a 5 points rate. 
-- 10. How could you take the top 3 regarding both user ratings and number of votes?
SELECT track_name, rating_count_tot, user_rating FROM ironhack_examples.applestore
ORDER BY rating_count_tot and user_rating DESC
limit 3;
-- 11. Do people care about the price of an app? 
-- Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
-- Let's see the price of the most rated app 
-- To answer the questoin, I think we have to watch the number of votes meaning the number of users, and the user rates.
SELECT track_name, rating_count_tot, price FROM ironhack_examples.applestore
ORDER BY rating_count_tot DESC
LIMIT 20;
-- The most rated apps are almost all free, so people are interesting downloading free apps. 
select AVG(user_rating) from ironhack_examples.applestore
where price > 0; -- result is 4.0434
select AVG(user_rating) from ironhack_examples.applestore
where price = 0; -- result is 3.837
-- if we compare the average rate for free apps and for not free apps, there is no such difference of rate between free and not free apps.
SELECT track_name, user_rating, price FROM ironhack_examples.applestore
ORDER BY user_rating DESC
LIMIT 10;
-- Most of the best rated apps are paying apps, so paying apps can be more satisfying for the user. 
SELECT track_name, rating_count_tot, user_rating, price FROM ironhack_examples.applestore
ORDER BY rating_count_tot and user_rating DESC
limit 10;
-- Regarding both user rating and number of votes, and as conclusion it seems that people are more willing to download free apps but they are ready to pay the price to have access to quality apps. 

