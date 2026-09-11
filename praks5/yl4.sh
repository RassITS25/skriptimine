#!/bin/bash

#loeb systeemilt useri ja aja
aeg=$(date +%H)
kasutaja=$(whoami)

if [ "$aeg" -ge 6 ] && [ "$aeg" -lt 12 ]; then
    echo "Tere hommikust, $kasutaja!"
elif [ "$aeg" -ge 12 ] && [ "$aeg" -lt 18 ]; then
    echo "Tere päivast, $kasutaja!"
elif [ "$aeg" -ge 18 ] && [ "$aeg" -lt 22 ]; then
    echo "Tere õhtast, $kasutaja!"
elif [ "$aeg" -ge 22 ] && [ "$aeg" -lt 24 ] || [ "$aeg" -ge 0 ] && [ "$aeg" -lt 6 ]; then
    echo "Hääd ööd, $kasutaja!"
else
    echo "Midagi läks metsa."
fi
