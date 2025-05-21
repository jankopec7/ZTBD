# Projekt z przedmiotu Zaawansowane Technologie Baz Danych

## MongoDB 7 i MongoDB 8 w Dockerze

Ten projekt demonstruje, jak uruchomić dwa różne środowiska MongoDB (7 i 8) w kontenerach Docker, używając plików CSV do importu danych. Skrypty pozwalają na zbudowanie obrazów Docker, uruchomienie kontenerów, import danych oraz wykonanie testów wydajnościowych.

## Struktura repozytorium

├── mongo7/ # Dockerfile dla MongoDB 7
├── mongo8/ # Dockerfile dla MongoDB 8
├── csv_files/ # Folder z plikami CSV (nie śledzony przez Git - trzeba ręcznie stworzyć taki katalog i wrzuić tam pliki z danymi .csv)
├── build.sh # Skrypt budowania obrazów
├── run.sh # Skrypt uruchamiania kontenerów
├── load.sh # Skrypt importowania danych do obu Mongo
├── manual_import.sh # Skrypt do ręcznego importu plików CSV do MongoDB 8
├── mongo_testy.js # Skrypt z testami wydajnościowymi MongoDB
├── sql_testy.sql # plik z analogicznymi zapytaniami SQL do testów porównawczych
├── .gitignore
└── README.md


## Wymagania

- Docker
- Git
- Ubuntu

## Instalacja i Uruchomienie

1. **Zainstaluj Docker:**

   Jeśli jeszcze nie masz zainstalowanego Dockera, postępuj zgodnie z oficjalną dokumentacją [Docker Install](https://docs.docker.com/get-docker/).

2. **Sklonuj repozytorium**

```bash
git clone <link_do_repozytorium>
cd <nazwa_repo>

3. **Zbuduj obrazy**
```bash
./build.sh

4. **Uruchom kontenery**

```bash
./run.sh

5. **Załaduj dane z plików CSV**

```bash
./load_data.sh

6. **Problemy z importem w MongoDB 8**

Podczas testów zauważono, że przy imporcie pliku ratings.csv do MongoDB 8 mogą wystąpić problemy.

W takim przypadku możesz skorzystać z ręcznego importu:

```bash
./manual_import.sh



7. **Testowanie zapytań**

Aby przetestować zapytania wydajnościowe:

```bash
docker cp mongo_testy.js mongo7-container:/mongo_testy.js  
docker exec -it mongo7-container mongosh mojaBaza mongo_testy.js

```bash
docker cp mongo_testy.js mongo8-container:/mongo_testy.js  
docker exec -it mongo8-container mongosh mojaBaza /mongo_testy.js 