-- Challenge 1
use publications;
-- Calculate the royalty of each sale for each author and the advance for each author and publication.
SELECT sales.title_id AS title_ID, 
	titleauthor.au_id AS au_ID, 
    titles.advance * titleauthor.royaltyper / 100 AS advance, 
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty 
FROM 
publications.sales AS sales
LEFT JOIN publications.titleauthor AS titleauthor
ON sales.title_id = titleauthor.title_id
LEFT JOIN publications.titles AS titles
ON titleauthor.title_id = titles.title_id
GROUP BY sales.title_id, titleauthor.au_id, advance, sales_royalty;
-- 34 rows returned

-- Aggregate the total royalties for each title and author
SELECT title_ID, au_ID, sum(sales_royalty) AS sum_sales_royalty
FROM (
	SELECT sales.title_id AS title_ID, 
		titleauthor.au_id AS au_ID, 
		titles.advance * titleauthor.royaltyper / 100 AS advance, 
		titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty 
	FROM 
	publications.sales AS sales
	LEFT JOIN publications.titleauthor AS titleauthor
	ON sales.title_id = titleauthor.title_id
	LEFT JOIN publications.titles AS titles
	ON titleauthor.title_id = titles.title_id
	GROUP BY sales.title_id, titleauthor.au_id, advance, sales_royalty
    ) step1
GROUP BY au_ID, title_ID;
-- 24 rows - here title_ID can appear twice if it was written by two differents authors. 

-- Calculate the total profits of each author
SELECT au_ID, advance + sum_sales_royalty AS total_profit
FROM (
	SELECT title_ID, au_ID, sum(sales_royalty) AS sum_sales_royalty, advance
	FROM 
    (
		SELECT sales.title_id AS title_ID, 
			titleauthor.au_id AS au_ID, 
			titles.advance * titleauthor.royaltyper / 100 AS advance, 
			titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty 
		FROM 
		publications.sales AS sales
		LEFT JOIN publications.titleauthor AS titleauthor
		ON sales.title_id = titleauthor.title_id
		LEFT JOIN publications.titles AS titles
		ON titleauthor.title_id = titles.title_id
		GROUP BY sales.title_id, titleauthor.au_id, advance, sales_royalty
		) step1
	GROUP BY au_ID, title_ID
    ) step2
GROUP BY au_ID, total_profit
ORDER BY total_profit DESC
LIMIT 3;
-- we need to keep the advance column on the step 2

-- Challenge 2 - Alternative Solution 
CREATE TEMPORARY TABLE step1
SELECT sales.title_id AS title_ID, 
	titleauthor.au_id AS au_ID, 
    titles.advance * titleauthor.royaltyper / 100 AS advance, 
    titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty 
FROM 
publications.sales AS sales
LEFT JOIN publications.titleauthor AS titleauthor
ON sales.title_id = titleauthor.title_id
LEFT JOIN publications.titles AS titles
ON titleauthor.title_id = titles.title_id
GROUP BY sales.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper / 100, sales_royalty;

DROP TABLE step2;
CREATE TEMPORARY TABLE step2
SELECT title_ID, au_ID, sum(sales_royalty) AS sum_sales_royalty, advance
FROM step1
GROUP BY au_ID, title_ID, advance;

CREATE TEMPORARY TABLE total_profits
SELECT au_ID, advance + sum_sales_royalty AS total_profit
FROM step2
GROUP BY au_ID, total_profit
ORDER BY total_profit DESC
LIMIT 3;

-- Challenge 3 - 

CREATE TABLE most_profiting_authors
SELECT au_ID, advance + sum_sales_royalty AS total_profit
FROM (
	SELECT title_ID, au_ID, sum(sales_royalty) AS sum_sales_royalty, advance
	FROM 
    (
		SELECT sales.title_id AS title_ID, 
			titleauthor.au_id AS au_ID, 
			titles.advance * titleauthor.royaltyper / 100 AS advance, 
			titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 AS sales_royalty 
		FROM 
		publications.sales AS sales
		LEFT JOIN publications.titleauthor AS titleauthor
		ON sales.title_id = titleauthor.title_id
		LEFT JOIN publications.titles AS titles
		ON titleauthor.title_id = titles.title_id
		GROUP BY sales.title_id, titleauthor.au_id, titles.advance * titleauthor.royaltyper, sales_royalty
		) step1
	GROUP BY au_ID, title_ID
    ) step2
GROUP BY au_ID, total_profit
ORDER BY total_profit DESC
LIMIT 3;

