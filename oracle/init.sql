-- tworzysz tabele, bez importu CSV – dane wczytamy ręcznie

CREATE TABLE movies (
  movieId NUMBER PRIMARY KEY,
  title VARCHAR2(4000),
  genres VARCHAR2(4000)
);

CREATE TABLE ratings (
  userId NUMBER,
  movieId NUMBER,
  rating NUMBER(3,2),
  timestamp NUMBER
);

CREATE TABLE tags (
  userId NUMBER,
  movieId NUMBER,
  tag VARCHAR2(4000),
  timestamp NUMBER
);

CREATE TABLE links (
  movieId NUMBER PRIMARY KEY,
  imdbId VARCHAR2(50),
  tmdbId VARCHAR2(50)
);
