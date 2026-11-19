#!/bin/bash

TEENUS="nginx"

if dpkg-query -W -f='${Status}' "$TEENUS" 2>/dev/null | grep -q "ok installed"; then
    echo "Teenus '$TEENUS' on juba paigaldatud, lock in!"
    systemctl status "$TEENUS" --no-pager
else
    echo "Teenus '$TEENUS' ei ole paigaldatud, lock in! Paigaldan ise su eest siis...!"
    if apt-get update && apt-get install -y "$TEENUS"; then
        echo "Paigaldatud raisk! Nginx staatus:"
        systemctl status "$TEENUS" --no-pager
    else
        echo "VIGA: Teenuse '$TEENUS' paigaldamine ebaõnnestus. Kontrolli õigusi (sudo/root), võrku ja veateateid. LOCK INNN"
        exit 1
    fi
fi
