#!/usr/bin/env bash

# Kontrollime, kas teenuse nimi sisestati.
if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "VIGA: Sisesta teenuse nimi!"
    exit 2
fi

SERVICE="$1"

# 1. Kontrollime kõigepealt, kas teenus üldse eksisteerib.
if ! systemctl list-unit-files "${SERVICE}.service" &>/dev/null; then
    echo "Teenus $SERVICE ei eksisteeri."
    exit 1
fi

# 2. Kui teenus on olemas, kontrollime selle olekut.
if systemctl is-active --quiet "${SERVICE}.service"; then
    echo "Teenus $SERVICE töötab."
    exit 0
else
    echo "Teenus $SERVICE ei tööta."
    exit 1
fi
