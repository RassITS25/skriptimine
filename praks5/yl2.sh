#!/bin/bash

# kysime kuu numbri
read -p "Sisesta kuu number: " kuu

# motleb oige kuu
if [ "$kuu" -eq 1 ] || [ "$kuu" -eq 2 ] || [ "$kuu" -eq 12 ]; then
    echo "Praegu on talv"
elif [ "$kuu" -ge 3 ] && [ "$kuu" -le 5 ]; then
    echo "Praegu on kevad"
elif [ "$kuu" -ge 6 ] && [ "$kuu" -le 8 ]; then
    echo "Praegu on suvi"
elif [ "$kuu" -ge 9 ] && [ "$kuu" -le 11 ]; then
    echo "Praegu on sügis"
else
    echo "Antud kuu numbrit pole"
fi
