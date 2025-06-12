-- Włącz pomiar czasu w psql (alternatywnie ręcznie w terminalu: \timing)
\timing on

-- Zapytanie 1: Średnia ocena dla każdego gatunku
DO $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN
    RAISE NOTICE 'Zapytanie 1: Średnia ocena dla każdego gatunku';
    start_time := clock_timestamp();

    PERFORM * FROM (
        SELECT genre, AVG(r.rating) AS avg_rating
        FROM (
            SELECT r.*, unnest(string_to_array(m.genres, '|')) AS genre
            FROM ratings r
            JOIN movies m ON r.movieId = m.movieId
        ) sub
        GROUP BY genre
        ORDER BY avg_rating DESC
        LIMIT 5
    ) result;

    end_time := clock_timestamp();
    RAISE NOTICE 'Czas wykonania: % ms', EXTRACT(MILLISECOND FROM end_time - start_time) + EXTRACT(SECOND FROM end_time - start_time) * 1000;
END $$;

-- Zapytanie 2: Liczba ocen dla każdego tytułu
DO $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN
    RAISE NOTICE 'Zapytanie 2: Liczba ocen dla każdego tytułu';
    start_time := clock_timestamp();

    PERFORM * FROM (
        SELECT m.title, COUNT(*) AS rating_count
        FROM ratings r
        JOIN movies m ON r.movieId = m.movieId
        GROUP BY m.title
        ORDER BY rating_count DESC
        LIMIT 5
    ) result;

    end_time := clock_timestamp();
    RAISE NOTICE 'Czas wykonania: % ms', EXTRACT(MILLISECOND FROM end_time - start_time) + EXTRACT(SECOND FROM end_time - start_time) * 1000;
END $$;

-- Zapytanie 3: Średnia ocena dla każdego imdbId
DO $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN
    RAISE NOTICE 'Zapytanie 3: Średnia ocena dla każdego imdbId';
    start_time := clock_timestamp();

    PERFORM * FROM (
        SELECT l.imdbId, AVG(r.rating) AS avg_rating
        FROM ratings r
        JOIN links l ON r.movieId = l.movieId
        GROUP BY l.imdbId
        ORDER BY avg_rating DESC
        LIMIT 5
    ) result;

    end_time := clock_timestamp();
    RAISE NOTICE 'Czas wykonania: % ms', EXTRACT(MILLISECOND FROM end_time - start_time) + EXTRACT(SECOND FROM end_time - start_time) * 1000;
END $$;

-- Zapytanie 4: Filmy ocenione przez usera 6550 z tagami
DO $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN
    RAISE NOTICE 'Zapytanie 4: Filmy ocenione przez usera 6550 z tagami';
    start_time := clock_timestamp();

    PERFORM * FROM (
        SELECT m.title, r.rating, t.tag
        FROM ratings r
        JOIN tags t ON r.movieId = t.movieId AND r.userId = t.userId
        JOIN movies m ON r.movieId = m.movieId
        WHERE r.userId = 6550 AND r.rating >= 4.5
        LIMIT 5
    ) result;

    end_time := clock_timestamp();
    RAISE NOTICE 'Czas wykonania: % ms', EXTRACT(MILLISECOND FROM end_time - start_time) + EXTRACT(SECOND FROM end_time - start_time) * 1000;
END $$;
