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