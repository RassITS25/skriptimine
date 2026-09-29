#!/bin/bash

get_result_msg() {
    local count="$1"
    case $count in
        5) echo "Jäkkpott raibe! Multi triljönäär!(5/5)" ;;
        4) echo "Elab hästi(4/5)" ;;
        3) echo "Saab 1 loto pileti veel osta(3/5)" ;;
        2) echo "Natuke profit(2/5)" ;;
        1) echo "Sa oled ikka vaene(1/5)" ;;
        0) echo "Raha lännu.(0/5)" ;;
    esac
}

show_result() {
    local player_name="$1"
    local match_count="$2"
    RESULT_MSG=$(get_result_msg "$match_count")

    echo "======"
    echo "Mängija: $player_name"
    echo "Tabamusi: $match_count / 5"
    echo "Hinnang: $RESULT_MSG"
}
