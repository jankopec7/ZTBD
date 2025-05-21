-- 1️⃣ Liczba filmów w bazie
SELECT COUNT(*) FROM movies;

-- 2️⃣ Liczba ocen użytkownika 123
SELECT COUNT(*) FROM ratings WHERE userId = 123;

-- 3️⃣ Średnia ocena filmu 50
SELECT AVG(rating) FROM ratings WHERE movieId = 50;

-- 4️⃣ Top 5 filmów z największą liczbą ocen
SELECT movieId, COUNT(*) AS numRatings 
FROM ratings 
GROUP BY movieId 
ORDER BY numRatings DESC 
LIMIT 5;

-- 5️⃣ Liczba unikalnych użytkowników
SELECT COUNT(DISTINCT userId) FROM ratings;

-- 6️⃣ Filmy z tytułem zawierającym 'Star'
SELECT * FROM movies WHERE title LIKE '%Star%';

-- 7️⃣ Aktualizacja ocen użytkownika 456 dla filmów > 1000
UPDATE ratings SET rating = 5 
WHERE userId = 456 AND movieId > 1000;

-- 8️⃣ Usunięcie wszystkich ocen filmu 789
DELETE FROM ratings WHERE movieId = 789;

-- 9️⃣ Liczba filmów z roku 1999
SELECT COUNT(*) FROM movies WHERE title LIKE '%(1999)%';

-- 🔟 Liczba tagów filmu 50
SELECT COUNT(*) FROM tags WHERE movieId = 50;
