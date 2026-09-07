#!/bin/bash

echo "Sisesta sõnad"
echo -n "Esimene: "
read esimene
echo -n "Teine: "
read teine

t1=$(echo "$esimene" | rev | cut -c 1)
t2=$(echo "$teine" | rev | cut -c 1)

if [ "$t1" = "$t2" ]; then
    echo "Viimased tähed on samad"
else
    echo "Viimased sõnad on erinevad"
fi
