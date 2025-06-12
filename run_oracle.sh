#!/bin/bash
docker run -d --name oracle-container \
  -p 1521:1521 -p 5500:5500 \
  -v $(pwd)/oracle/data:/opt/oracle/scripts/data \
  oraclefree
