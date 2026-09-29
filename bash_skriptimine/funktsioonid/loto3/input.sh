#!/bin/bash

read_player() {
    local name
    read -p "Sisesta nimi: " name
    PLAYER_NAME=${name:-Unknown}
}

read_player_numbers() {
    PLAYER_NUMS=()
    local num

    while [ ${#PLAYER_NUMS[@]} -lt 5 ]; do
        read -p "Sisesta $(( ${#PLAYER_NUMS[@]} + 1 )). number (1-50): " num
        
        if [ -z "$num" ]; then
            echo "Viga: Sisend ei tohi olla tühi!"
        elif ! [[ "$num" =~ ^[0-9]+$ ]]; then
            echo "Viga: Peab olema täisarv!"
        elif [ "$num" -lt 1 ] || [ "$num" -gt 50 ]; then
            echo "Viga: Number peab olema vahemikus 1–50!"
        elif contains "$num" "${PLAYER_NUMS[@]}"; then
            echo "Viga: See number on juba valitud!"
        else
            PLAYER_NUMS+=("$num")
            echo "$num" >> player_numbers.txt
        fi
    done
}

show_player_numbers() {
    echo -e "\nSinu numbrid:"
    cat player_numbers.txt
}
