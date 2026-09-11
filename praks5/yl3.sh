#!/bin/bash

#kyisb aja
read -p "Sisesta aja väärtus: " aeg

# motleb vastuse
if [ "$aeg" -ge 6 ] && [ "$aeg" -lt 12 ]; then
    echo "Tere hommikust!"
elif [ "$aeg" -ge 12 ] && [ "$aeg" -lt 18 ]; then
    echo "Tere päivast!"
elif [ "$aeg" -ge 18 ] && [ "$aeg" -lt 22 ]; then
    echo "Tere õhtast!"
elif [ "$aeg" -ge 22 ] && [ "$aeg" -lt 24 ] || [ "$aeg" -ge 0 ] && [ "$aeg" -lt 6 ]; then
    echo "Hääd ööd!"
else
    echo "Sisestatud aeg pole aksepteeritav"
fi
