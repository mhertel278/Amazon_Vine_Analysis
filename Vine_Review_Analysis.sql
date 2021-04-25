
-- Create vine_table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

--filter to reviews over 20 votes
SELECT *
INTO vine_20_votes
FROM vine_table
WHERE total_votes >= 20;

--filter 20_votes table to where helpful votes > 50%
SELECT *
INTO vine_helpful_votes
FROM vine_20_votes
WHERE (helpful_votes :: FLOAT / total_votes:: FLOAT) >= 0.5;

--create table for paid Vine program
SELECT *
INTO vine_paid
FROM vine_helpful_votes
WHERE vine = 'Y'
;

--create table for not paid Vine program
SELECT *
INTO vine_unpaid
FROM vine_helpful_votes
WHERE vine = 'N'
;



-- Find total # of reviews with more than 20 votes
SELECT COUNT(*) as total_reviews
FROM vine_helpful_votes;


-- Find total # of 5-star reviews with more than 20 votes
SELECT star_rating
	, COUNT(review_id) as total_5_star_reviews
FROM vine_helpful_votes
GROUP BY star_rating
HAVING star_rating = 5 
;

-- Find percentage of paid vine reviews that were 5-stars
SELECT *
FROM
(SELECT star_rating
	, COUNT(review_id) as number_of_reviews
	, ROUND(((COUNT(review_id) / sum(COUNT(review_id)) over())* 100), 2) as percentage_of_reviews
FROM vine_paid
GROUP BY star_rating) as percentages
WHERE star_rating = 5
;

-- Find percentage of unpaid (non-vine) reviews that were 5-stars
SELECT *
FROM
(SELECT star_rating
	, COUNT(review_id) as number_of_reviews
	, ROUND(((COUNT(review_id) / SUM(COUNT(review_id)) over())* 100), 2) as percentage_of_reviews
FROM vine_unpaid
GROUP BY star_rating) as percentages
WHERE star_rating = 5
;