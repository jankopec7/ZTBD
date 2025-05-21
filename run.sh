#!/bin/bash

# Uruchomienie MongoDB 7
echo "Uruchamianie MongoDB 7..."
docker run -d --name mongo7-container -p 27017:27017 mongo7

#Uruchomienie MongoDB 8
echo "Uruchamianie MongoDB 8..."
docker run -d --name mongo8-container -p 27018:27017 mongo8

