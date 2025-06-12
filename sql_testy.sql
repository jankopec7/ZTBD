-- SELECT

-- 1. Average rating for each genre
SELECT m.genres, AVG(r.rating) AS avg_rating
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.genres;

-- 2. Number of ratings for each movie with the title
SELECT m.title, COUNT(*) AS rating_count
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.title;

-- 3. Average rating for each imdbId
SELECT l.imdbId, AVG(r.rating) AS avg_rating
FROM ratings r
JOIN links l ON r.movieId = l.movieId
GROUP BY l.imdbId;

-- 4. Movies that user 6550 rated >= 4.5 and tagged
SELECT m.title, r.rating, t.tag
FROM ratings r
JOIN tags t ON r.userId = t.userId AND r.movieId = t.movieId
JOIN movies m ON r.movieId = m.movieId
WHERE r.userId = 6550 AND r.rating >= 4.5;


-- UPDATE

-- 5. Update rating to 5.0 for all movies in the genre "Drama"
UPDATE ratings
SET rating = 5.0
FROM movies m
WHERE ratings.movieId = m.movieId AND m.genres LIKE '%Drama%';

-- 6. Update ratings by 0.5 less for movies with imdbId < 1000000
UPDATE ratings
SET rating = GREATEST(rating - 0.5, 0.5)
FROM links l
WHERE ratings.movieId = l.movieId AND l.imdbId < '1000000';

-- 7. Reset rating if user left tag "so bad it's good"
UPDATE ratings
SET rating = 0.0
FROM tags t
WHERE ratings.movieId = t.movieId AND ratings.userId = t.userId
  AND LOWER(t.tag) = 'so bad it''s good';


-- DELETE

-- 8. Delete low-rated entries that have no match in links by tmdbId
DELETE FROM ratings
WHERE rating < 2.0
  AND NOT EXISTS (
    SELECT 1 FROM links l
    WHERE l.movieId = ratings.movieId AND l.tmdbId IS NOT NULL
  );

-- 9. Delete all ratings for movies with genre "Documentary"
DELETE FROM ratings
USING movies m
WHERE ratings.movieId = m.movieId AND m.genres LIKE '%Documentary%';

-- 10. Delete all ratings that have the tag "boring"
DELETE FROM ratings
USING tags t
WHERE ratings.userId = t.userId AND ratings.movieId = t.movieId
  AND LOWER(t.tag) = 'boring';
