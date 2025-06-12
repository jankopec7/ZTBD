#!/bin/bash
echo "Budowanie obrazu PostgreSQL..."
docker build -t postgres-custom ./postgres
