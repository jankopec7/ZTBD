# Projekt z przedmiotu Zaawansowane Technologie Baz Danych

# MongoDB 7 i MongoDB 8 w Dockerze - Projekt

Ten projekt demonstruje, jak uruchomić dwa różne środowiska MongoDB (7 i 8) w kontenerach Docker, używając plików CSV do importu danych. Skrypt `build_and_run.sh` automatycznie buduje obrazy Docker, uruchamia kontenery i importuje dane.

## Struktura repozytorium

├── mongo7/ # Dockerfile i skrypt importu dla MongoDB 7
├── mongo8/ # Dockerfile i skrypt importu dla MongoDB 8
├── csv_files/ # Folder z plikami CSV (nie śledzony przez Git)
├── build_and_run.sh # Skrypt do budowania i uruchamiania kontenerów
├── .gitignore
└── README.md


## Wymagania

- Docker
- Git

## Instalacja i Uruchomienie

1. **Zainstaluj Docker:**

   Jeśli jeszcze nie masz zainstalowanego Dockera, postępuj zgodnie z oficjalną dokumentacją [Docker Install](https://docs.docker.com/get-docker/).

2. **Skopiuj repozytorium:**

   Możesz sklonować to repozytorium lub pobrać je w formie archiwum:

   ```bash
   git clone <link_do_repozytorium>
   cd <nazwa_repo>
