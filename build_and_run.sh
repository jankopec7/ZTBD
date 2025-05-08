#!/bin/bash

# Budowanie i uruchamianie MongoDB 7
echo "Budowanie obrazu Docker dla MongoDB 7..."
cd mongo7
docker build -t mongo7 .
cd ..
echo "Uruchamianie kontenera MongoDB 7..."
docker run -d --name mongo7-container -p 27017:27017 -v "$(pwd)/csv_files:/csv_files" mongo7

# Czekamy chwilę, aż MongoDB 7 wystartuje
echo "Czekam, aż MongoDB 7 wystartuje..."
sleep 10  # Możesz dostosować czas oczekiwania, aby dać kontenerowi wystarczająco dużo czasu na uruchomienie

# Importowanie danych do MongoDB 7
echo "Importowanie danych do MongoDB 7..."
docker exec -it mongo7-container bash /import_data.sh

# Budowanie i uruchamianie MongoDB 8
echo "Budowanie obrazu Docker dla MongoDB 8..."
cd mongo8
docker build -t mongo8 .
cd ..
echo "Uruchamianie kontenera MongoDB 8..."
docker run -d --name mongo8-container -p 27018:27018 -v "$(pwd)/csv_files:/csv_files" mongo8

# Czekamy chwilę, aż MongoDB 8 wystartuje
echo "Czekam, aż MongoDB 8 wystartuje..."
sleep 10  # Możesz dostosować czas oczekiwania

# Importowanie danych do MongoDB 8
echo "Importowanie danych do MongoDB 8..."
docker exec -it mongo8-container bash /import_data.sh

echo "Proces zakończony!"

