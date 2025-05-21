# Projekt z przedmiotu Zaawansowane Technologie Baz Danych

## MongoDB 7 i MongoDB 8 w Dockerze

Ten projekt demonstruje, jak uruchomić dwa różne środowiska MongoDB (7 i 8) w kontenerach Docker, używając plików CSV do importu danych. Skrypty pozwalają na zbudowanie obrazów Docker, uruchomienie kontenerów, import danych oraz wykonanie testów wydajnościowych.

## Struktura repozytorium

```
.
├── mongo7/                    # Dockerfile i konfiguracja dla MongoDB 7
├── mongo8/                    # Dockerfile i konfiguracja dla MongoDB 8
├── csv_files/                 # Folder z plikami CSV (nie śledzony przez Git — trzeba stworzyć ręcznie)
│   └── (movies.csv, ratings.csv, tags.csv, links.csv)
│
├── build.sh                   # Skrypt budowania obrazów Docker dla baz danych
├── run.sh                     # Skrypt uruchamiania kontenerów Docker
├── load.sh                    # Skrypt importowania danych do MongoDB 7 i 8
├── manual_import.sh           # Skrypt do ręcznego importu plików CSV do MongoDB 8
│
├── mongo_testy.js             # Skrypt z testami wydajnościowymi dla MongoDB 7 i 8
├── sql_testy.sql              # Skrypt SQL z testami wydajnościowymi dla PostgreSQL i OracleDB
│
├── .gitignore                 # Plik ignorujący zbędne pliki w repozytorium (np. csv_files/)
└── README.md                  # Opis projektu i instrukcja obsługi
```
## Wymagania

- Docker
- Git
- Ubuntu

## Instalacja i Uruchomienie

1. **Zainstaluj Docker:**

   Jeśli jeszcze nie masz zainstalowanego Dockera, postępuj zgodnie z oficjalną dokumentacją [Docker Install](https://docs.docker.com/get-docker/).

2. **Sklonuj i korzystaj z repo**

```bash
git clone <link_do_repozytorium>
cd <nazwa_repo>

**Zbuduj obrazy**

./build.sh

**Uruchom kontenery**

./run.sh

**Załaduj dane z plików CSV**

./load_data.sh

**Problemy z importem w MongoDB 8**

Podczas testów zauważono, że przy imporcie pliku ratings.csv do MongoDB 8 mogą wystąpić problemy.

W takim przypadku możesz skorzystać z ręcznego importu:

./manual_import.sh


**Testowanie zapytań**

Aby przetestować zapytania wydajnościowe:

docker cp mongo_testy.js mongo7-container:/mongo_testy.js  
docker exec -it mongo7-container mongosh mojaBaza mongo_testy.js

docker cp mongo_testy.js mongo8-container:/mongo_testy.js  
docker exec -it mongo8-container mongosh mojaBaza /mongo_testy.js 