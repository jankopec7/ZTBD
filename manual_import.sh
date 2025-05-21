#!/bin/bash

echo "Kopiowanie wszystkich plików CSV do kontenera..."
docker cp csv_files/ mongo8-container:/csv_files/

echo "Importowanie danych do MongoDB 8..."

docker exec mongo8-container mongoimport --db mojaBaza --collection ratings --type csv --headerline --file /csv_files/ratings.csv
docker exec mongo8-container mongoimport --db mojaBaza --collection movies --type csv --headerline --file /csv_files/movies.csv
docker exec mongo8-container mongoimport --db mojaBaza --collection tags --type csv --headerline --file /csv_files/tags.csv
docker exec mongo8-container mongoimport --db mojaBaza --collection links --type csv --headerline --file /csv_files/links.csv

echo "Import zakończony."
