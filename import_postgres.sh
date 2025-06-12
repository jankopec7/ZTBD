#!/bin/bash

FILES=(ratings movies tags links)
for file in "${FILES[@]}"; do
  echo "Importowanie $file.csv..."
  docker exec -i postgres-container psql -U admin -d mojabaza -c "\
    COPY $file FROM '/csv_files/$file.csv' DELIMITER ',' CSV HEADER;"
done
