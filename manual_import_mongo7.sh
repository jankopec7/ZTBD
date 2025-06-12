#!/bin/bash

echo "Kopiowanie wszystkich plików CSV do kontenera MongoDB 7..."
docker cp csv_files mongo7-container:/

echo "Importowanie danych do MongoDB 7..."

docker exec mongo7-container mongoimport --db mojaBaza --collection ratings --type csv --headerline --file /csv_files/ratings.csv
docker exec mongo7-container mongoimport --db mojaBaza --collection movies --type csv --headerline --file /csv_files/movies.csv
docker exec mongo7-container mongoimport --db mojaBaza --collection tags --type csv --headerline --file /csv_files/tags.csv
docker exec mongo7-container mongoimport --db mojaBaza --collection links --type csv --headerline --file /csv_files/links.csv

echo "Import danych do MongoDB 7 zakończony."
