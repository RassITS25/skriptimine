#!/bin/bash

for (( n=1000; n<9999; n++ )); do
    arv=$n
    while [ $arv -gt 9 ]; do
        summa=0
        temp=$arv
        while [ $temp -gt 0 ]; do
            summa=$(( summa + temp % 10 ))
            temp=$(( temp / 10 ))
        done
        arv=$summa
    done
    [ $arv -eq 7 ] && echo $n
done
