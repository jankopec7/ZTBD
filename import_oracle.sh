#!/bin/bash

FILES=(ratings movies tags links)

for file in "${FILES[@]}"; do
  echo "Importowanie ${file}.csv..."

  docker exec -i oracle-container bash -c "
    echo \"
    LOAD DATA
    INFILE '/opt/oracle/scripts/data/${file}.csv'
    INTO TABLE ${file}
    FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    SKIP 1
    (
      $(head -n1 csv_files/${file}.csv | sed 's/,/,\n/g')
    )
    \" > /opt/oracle/scripts/data/${file}.ctl

    sqlldr userid=admin/Oracle123@ORCLCDB \
      control=/opt/oracle/scripts/data/${file}.ctl \
      log=/opt/oracle/scripts/data/${file}.log \
      bad=/opt/oracle/scripts/data/${file}.bad \
      direct=true
  "
done
