#!/bin/bash

read -p "Ridade arv: " rida
read -p "Sümbolite arv reas: " sumbol

for (( i = 1; i <= rida; i++ ))
do
    for (( j = 1 ; j <= sumbol; j++ ))
    do
          echo -n "$i "
    done
  echo "" 
done
