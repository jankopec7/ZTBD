FROM postgres:17.4

ENV POSTGRES_DB=mojabaza
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=admin

# kopiujemy tylko init.sql, CSV będzie osobno kopiowane
COPY init.sql /docker-entrypoint-initdb.d/