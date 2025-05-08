#!/bin/bash

# Ustawienie zmiennej wskazującej na folder CSV
CSV_FOLDER="/csv_files"

# Sprawdzamy, czy folder z plikami CSV istnieje
if [ ! -d "$CSV_FOLDER" ]; then
    echo "Folder z plikami CSV nie istnieje: $CSV_FOLDER"
    exit 1
fi

# Import danych do MongoDB 8
echo "Importowanie danych do MongoDB 8..."
mongoimport --db movielens --collection movies --type csv --headerline --file ${CSV_FOLDER}/movies.csv
mongoimport --db movielens --collection ratings --type csv --headerline --file ${CSV_FOLDER}/ratings.csv
mongoimport --db movielens --collection tags --type csv --headerline --file ${CSV_FOLDER}/tags.csv
mongoimport --db movielens --collection links --type csv --headerline --file ${CSV_FOLDER}/links.csv

echo "Import danych zakończony."
