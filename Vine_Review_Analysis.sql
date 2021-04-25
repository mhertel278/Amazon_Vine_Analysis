
-- Create vine_table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);


--Step 1: filter to reviews over 20 votes
SELECT *
INTO vine_20_votes
FROM vine_table
WHERE total_votes >= 20;

--Step 2: filter 20_votes table to where helpful votes > 50%
SELECT *
INTO vine_helpful_votes
FROM vine_20_votes
WHERE (helpful_votes :: FLOAT / total_votes:: FLOAT) >= 0.5;

--Step 3: create table for paid Vine program
SELECT *
INTO vine_paid
FROM vine_helpful_votes
WHERE vine = 'Y'
;

--Step 4: create table for not paid Vine program
SELECT *
INTO vine_unpaid
FROM vine_helpful_votes
WHERE vine = 'N'
;


--Step 5: Find total # of paid vine reviews
SELECT COUNT(*) as total_reviews
FROM vine_paid;

--Step 5: Find total # of non-paid reviews
SELECT COUNT(*) as total_reviews
FROM vine_unpaid;

--Step 5: Find number of and percentage of paid vine reviews that were 5-stars
SELECT *
FROM
(SELECT star_rating
	, COUNT(review_id) as number_of_reviews
	, ROUND(((COUNT(review_id) / sum(COUNT(review_id)) over())* 100), 2) as percentage_of_reviews
FROM vine_paid
GROUP BY star_rating) as percentages
WHERE star_rating = 5
;

--Step 5: Find number of and percentage of unpaid (non-vine) reviews that were 5-stars
SELECT *
FROM
(SELECT star_rating
	, COUNT(review_id) as number_of_reviews
	, ROUND(((COUNT(review_id) / SUM(COUNT(review_id)) over())* 100), 2) as percentage_of_reviews
FROM vine_unpaid
GROUP BY star_rating) as percentages
WHERE star_rating = 5
;