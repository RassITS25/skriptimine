#!/bin/bash

contains() {
    local val="$1"; shift
    local item
    for item in "$@"; do
        if [ "$item" -eq "$val" ] 2>/dev/null; then 
            return 0 
        fi
    done
    return 1
}

generate_lottery_numbers() {
    LOTTERY_NUMS=()
    local rand_num

    while [ ${#LOTTERY_NUMS[@]} -lt 5 ]; do
        rand_num=$(( ($RANDOM % 50) + 1 ))
        if ! contains "$rand_num" "${LOTTERY_NUMS[@]}"; then
            LOTTERY_NUMS+=("$rand_num")
            echo "$rand_num" >> lottery_numbers.txt
        fi
    done
}

show_lottery_numbers() {
    echo -e "\nVõidunumbrid:"
    cat lottery_numbers.txt
    echo "--------------------------------"
}

check_matches() {
    local p_num
    MATCH_COUNT=0

    while read -r p_num; do
        echo "Kontrollin numbrit $p_num..."
        if contains "$p_num" "${LOTTERY_NUMS[@]}"; then
            echo "Pihtas põhjas raisk sa võitsid MIDAGI!"
            MATCH_COUNT=$((MATCH_COUNT + 1))
        else
            echo "Sa kaotasid kõik enda raha. Sa oled nüüd kodutu."
        fi
        echo ""
    done < player_numbers.txt
}
