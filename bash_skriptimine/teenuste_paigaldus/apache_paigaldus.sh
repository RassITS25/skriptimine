#!/bin/bash

TEENUS="apache2"

if dpkg-query -W -f='${Status}' "$TEENUS" 2>/dev/null | grep -q "ok installed"; then
    echo "Teenus '$TEENUS' on juba paigaldatud."
    systemctl status "$TEENUS" --no-pager
else
    echo "Teenus '$TEENUS' ei ole paigaldatud. Paigaldan..."
    if apt-get update && apt-get install -y "$TEENUS"; then
        echo "Paigaldamine õnnestus! Teenuse staatus:"
        systemctl status "$TEENUS" --no-pager
    else
        echo "VIGA: Teenuse '$TEENUS' paigaldamine ebaõnnestus. Kontrolli õigusi (sudo/root), võrku ja veateateid."
        exit 1
    fi
fi
