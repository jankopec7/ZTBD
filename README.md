# Projekt z przedmiotu Zaawansowane Technologie Baz Danych

## MongoDB 7 i MongoDB 8 w Dockerze

Ten projekt demonstruje, jak uruchomić dwa różne środowiska MongoDB (7 i 8) w kontenerach Docker, używając plików CSV do importu danych. Skrypty pozwalają na zbudowanie obrazów Docker, uruchomienie kontenerów, import danych oraz wykonanie testów wydajnościowych.

## Struktura repozytorium

```
├── csv_files/                  # Folder z plikami CSV (movies.csv, ratings.csv, links.csv, tags.csv)
│
├── mongo7/                     # Dockerfile i konfiguracja MongoDB 7
├── mongo8/                     # Dockerfile i konfiguracja MongoDB 8
├── postgres/                   # Dockerfile, init.sql dla PostgreSQL
├── oracle/                     # Dockerfile, init.sql dla Oracle Free
│
├── build_mongo.sh             # Budowanie MongoDB 7/8
├── build_postgres.sh          # Budowanie PostgreSQL
├── build_oracle.sh            # Budowanie Oracle Free
│
├── run_mongo.sh               # Uruchamianie kontenerów MongoDB
├── run_postgres.sh            # Uruchamianie PostgreSQL
├── run_oracle.sh              # Uruchamianie OracleDB
│
├── import_mongo.sh            # Import danych do MongoDB
├── manual_import_mongo7.sh    # Ręczny import do MongoDB 7
├── manual_import.sh           # Ręczny import do MongoDB 8
├── import_postgres.sh         # Import CSV do PostgreSQL
├── import_oracle.sh           # Import danych do Oracle (SQL*Loader / COPY)
│
├── mongo_testy_select.js      # Zapytania testowe dla MongoDB
├── mongo_testy_select_single_run.js
├── sql_testy.sql              # Testy SQL dla PostgreSQL i Oracle
├── test_queries.sql           # Zapytania EXPLAIN ANALYZE do PostgreSQL
│
├── README.md
└── .gitignore

```
## Wymagania

- Docker
- Git
- Ubuntu
- Oracle konto do pobrania obrazu

## Instalacja i Uruchomienie

**Zainstaluj Docker:**

   Jeśli jeszcze nie masz zainstalowanego Dockera, postępuj zgodnie z oficjalną dokumentacją [Docker Install](https://docs.docker.com/get-docker/).

**Sklonuj i korzystaj z repo**

```bash
git clone <link_do_repozytorium>
cd <nazwa_repo>
```

**Dodaj pliki CSV do katalogu csv_files/**
```
movies.csv
ratings.csv
tags.csv
links.csv
```

**Budowanie kontenerów**
```
# Mongo 7 i 8
./build.sh

# PostgreSQL
./build_postgres.sh

# Oracle (logowanie wymagane do container-registry.oracle.com)
./build_oracle.sh

```
**Uruchamianie kontenerów**
```
./run_mongo.sh
./run_postgres.sh
./run_oracle.sh

```
**Import danych**
```
./load_data.sh - stara wersja

# MongoDB 7 i 8
./manual_import_mongo7.sh
./manual_import.sh

# PostgreSQL
./import_postgres.sh

# Oracle
./import_oracle.sh

```
**Problemy z importem w MongoDB 8**

Podczas testów zauważono, że przy imporcie pliku ratings.csv do MongoDB 8 mogą wystąpić problemy.

W takim przypadku możesz skorzystać z ręcznego importu:
```
./manual_import.sh
```

**Testowanie zapytań**

Aby przetestować zapytania wydajnościowe:
```
docker cp mongo_testy.js mongo7-container:/mongo_testy.js  
docker exec -it mongo7-container mongosh mojaBaza mongo_testy.js

docker cp mongo_testy.js mongo8-container:/mongo_testy.js  
docker exec -it mongo8-container mongosh mojaBaza /mongo_testy.js

docker exec -it postgres-container psql -U admin -d mojaBaza -f /csv_files/sql_testy.sql

docker exec -it oracle-container sqlplus ADMIN/admin@//localhost:1521/FREE
@/opt/oracle/scripts/data/sql_testy.sql
```