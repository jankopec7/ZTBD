#!/bin/bash

docker run -d \
  --name postgres-container \
  -e POSTGRES_USER=admin \
  -e POSTGRES_PASSWORD=admin \
  -e POSTGRES_DB=mojabaza \
  -v $(pwd)/csv_files:/csv_files \
  -p 5432:5432 \
  postgres-custom
