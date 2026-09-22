#!/bin/bash

tmp=$(mktemp)

while [ $(wc -l < "$tmp") -lt 5 ]; do
    num=$(( RANDOM % 50 + 1 ))
    grep -qx "$num" "$tmp" || echo "$num" >> "$tmp"
done

tulemus="$(date '+%Y-%m-%d %H:%M:%S') - $(cat "$tmp")"
rm -f "$tmp"

read -p "Kuhu tahad numbrid saada? 1) Terminal  2) Faili: " v

if [ "$v" = "2" ]; then
    echo "$tulemus" >> tulemused.txt
else
    echo "$tulemus"
fi
