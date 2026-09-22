#!/bin/bash

#Küsime andmed
read -p "Ridade arv: " read_rows
for (( i=1; i<=read_rows; i++ ))
do
    echo -n "$i. "
    for (( j=1; j<=read_rows-i; j++ ))
    do
	echo -n "o "
    done
    for (( j=1; j<=read_rows-i; j++ ))
    do
	echo -n "* "
    done
    echo ""
done
