#!/bin/bash

echo "Budowanie obrazu MongoDB 7..."
docker build -t mongo7 ./mongo7

echo "Budowanie obrazu MongoDB 8..."
docker build -t mongo8 ./mongo8