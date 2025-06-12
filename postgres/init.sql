DROP TABLE IF EXISTS ratings, movies, tags, links;

CREATE TABLE movies (
  movieId INT PRIMARY KEY,
  title TEXT,
  genres TEXT
);

CREATE TABLE ratings (
  userId INT,
  movieId INT,
  rating FLOAT,
  timestamp BIGINT
);

CREATE TABLE tags (
  userId INT,
  movieId INT,
  tag TEXT,
  timestamp BIGINT
);

CREATE TABLE links (
  movieId INT PRIMARY KEY,
  imdbId TEXT,
  tmdbId TEXT
);
