#!/bin/bash

# Uruchomienie MongoDB 7 w tle
echo "Uruchamianie MongoDB 7..."
docker run -d --name mongo7-container -p 27017:27017 mongo7

# Poczekaj chwilę na start
echo "Czekam 5 sekund na start MongoDB 7..."
sleep 5

# Import danych do MongoDB 7
echo "Importowanie danych do MongoDB 7..."
docker exec mongo7-container mongoimport --db test --collection example --type csv --file /csv_files/data.csv --headerline

# Wylistuj bazy
docker exec -it mongo7-container mongosh --eval "show dbs"

# Dla MongoDB 8 podobnie:
echo "Uruchamianie MongoDB 8..."
docker run -d --name mongo8-container -p 27018:27017 mongo8

echo "Czekam 5 sekund na start MongoDB 8..."
sleep 5

echo "Importowanie danych do MongoDB 8..."
docker exec mongo8-container mongoimport --db test --collection example --type csv --file /csv_files/data.csv --headerline --port 27017

docker exec -it mongo8-container mongosh --eval "show dbs"
