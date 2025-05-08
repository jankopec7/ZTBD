# Używamy oficjalnego obrazu MongoDB 8
FROM mongo:8

# Ustawienie katalogu roboczego
WORKDIR /csv_files

# Skopiowanie skryptu importu danych
COPY import_data.sh /import_data.sh
RUN chmod +x /import_data.sh

# Uruchomienie MongoDB i załadowanie danych
CMD ["bash", "/import_data.sh"]
