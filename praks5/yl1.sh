#!/bin/bash

# Kysib vanust/arvu 
read -p "Sisesta oma vanus: " vanus

# motleb valja vastuse olenevalt sisestatud vanusest
if [ "$vanus" -ge 0 ] && [ "$vanus" -le 11 ]; then
    echo "Oled tatikas"
elif [ "$vanus" -ge 11 ] && [ "$vanus" -lt 18 ]; then
    echo "Oled nooruk"
elif [ "$vanus" -ge 18 ] && [ "$vanus" -lt 63 ]; then
    echo "Oled unc"
elif [ "$vanus" -ge 63 ]; then
    echo "Oled väga vana"
else
    echo "Vigane arv"
fi
