#!/bin/bash
# vaatab et arve oleks 3
if [ "$#" -ne 3 ]; then
    echo "Kasutus: $0 A B C"
    exit 1
fi

A=$1
B=$2
C=$3

# vaatab, et  A ei oleks 0
if [ $(echo "$A == 0" | bc -l) -eq 1 ]; then
    echo "Viga: A ei tohi olla 0!"
    exit 1
fi

# fancy arvutamine
D=$(echo "$B^2 - 4*$A*$C" | bc -l)

# kontrollimine
if [ $(echo "$D < 0" | bc -l) -eq 1 ]; then
    echo "Reaalarvulisi lahendeid ei ole."
elif [ $(echo "$D == 0" | bc -l) -eq 1 ]; then
    x=$(echo "-1*$B / (2*$A)" | bc -l)
    printf "x = %.5f\n" "$x"
else
    x1=$(echo "(-1*$B + sqrt($D)) / (2*$A)" | bc -l)
    x2=$(echo "(-1*$B - sqrt($D)) / (2*$A)" | bc -l)
    printf "x1 = %.5f\n" "$x1"
    printf "x2 = %.5f\n" "$x2"
fi
