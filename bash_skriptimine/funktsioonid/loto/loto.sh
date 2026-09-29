#!/bin/bash

# 1. Algseadistus
> player_numbers.txt
> lottery_numbers.txt

# Abifunktsioon: kontrollib, kas otsitav väärtus ($1) on massiivis (ülejäänud argumendid)
contains() {
    local val="$1"; shift
    for item in "$@"; do
        if [ "$item" -eq "$val" ] 2>/dev/null; then return 0; fi
    done
    return 1
}

# Abifunktsioon: märkide ja tulemuste kuvamiseks
get_result_msg() {
    case $1 in
        5) echo "Jäkkpott raibe! Multi triljönäär!(5/5)" ;;
        4) echo "Elab hästi(4/5)" ;;
        3) echo "Saab 1 loto pileti veel osta(3/5)" ;;
        2) echo "Natuke profit(2/5)" ;;
        1) echo "Sa oled ikka vaene(1/5)" ;;
        0) echo "Raha lännu.(0/5)" ;;
    esac
}

# 2. Mängija andmete küsimine
read -p "Sisesta nimi: " PLAYER_NAME
PLAYER_NAME=${PLAYER_NAME:-Unknown}

# 3. Mängija numbrite sisestamine
PLAYER_NUMS=()
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

echo -e "\nSinu numbrid:"
cat player_numbers.txt

# 4. Loosimine
LOTTERY_NUMS=()
while [ ${#LOTTERY_NUMS[@]} -lt 5 ]; do
    rand_num=$(( ($RANDOM % 50) + 1 ))
    if ! contains "$rand_num" "${LOTTERY_NUMS[@]}"; then
        LOTTERY_NUMS+=("$rand_num")
        echo "$rand_num" >> lottery_numbers.txt
    fi
done

echo -e "\nVõidunumbrid:"
cat lottery_numbers.txt
echo "--------------------------------"

# 5. Tulemuste kontrollimine
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

RESULT_MSG=$(get_result_msg $MATCH_COUNT)

echo "======"
echo "Mängija: $PLAYER_NAME"
echo "Tabamusi: $MATCH_COUNT / 5"
echo "Hinnang: $RESULT_MSG"

# 6. Salvestamine ajaloo faili
{
    echo "====="
    echo "Date: $(date)"
    echo "Player: $PLAYER_NAME"
    echo "Player numbers:"
    cat player_numbers.txt
    echo "Lottery numbers:"
    cat lottery_numbers.txt
    echo "Matches: $MATCH_COUNT"
    echo "Result: $RESULT_MSG"
} >> results.txt
