FROM mongo:7

# Ustawienie katalogu roboczego
WORKDIR /csv_files

# Skrypt importu
COPY import_data.sh /import_data.sh
RUN chmod +x /import_data.sh

# Uruchomienie MongoDB i załadowanie danych
CMD ["bash", "/import_data.sh"]

