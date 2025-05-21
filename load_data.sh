#!/bin/bash

# Nazwy kontenerów
CONTAINERS=("mongo7-container" "mongo8-container")

# Ścieżka do katalogu z CSV
CSV_DIR="./csv_files"

# Nazwa bazy
DB_NAME="mojaBaza"

echo "Kopiuję pliki CSV do kontenerów..."

# Kopiowanie CSV do obu kontenerów
for container in "${CONTAINERS[@]}"; do
    docker cp "$CSV_DIR" "$container":/
done

# Iteracja po wszystkich plikach CSV
for file in "$CSV_DIR"/*.csv; do
    filename=$(basename -- "$file")
    collection="${filename%.*}"

    echo ""
    echo "Importuję $filename do kolekcji $collection..."

    for container in "${CONTAINERS[@]}"; do
        echo "  -> Import do kontenera $container"
        
        docker exec "$container" mongoimport \
            --db "$DB_NAME" \
            --collection "$collection" \
            --type csv \
            --headerline \
            --file "/csv_files/$filename"

        echo "  -> Liczba dokumentów w $collection w $container:"
        docker exec "$container" mongosh --quiet --eval "db.getSiblingDB('$DB_NAME').$collection.countDocuments()"
    done
done

echo ""
echo "Wszystkie pliki zaimportowane do obu kontenerów."
