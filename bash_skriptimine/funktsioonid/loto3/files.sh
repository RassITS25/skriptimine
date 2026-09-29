#!/bin/bash

clear_files() {
    > player_numbers.txt
    > lottery_numbers.txt
}

save_result() {
    local player_name="$1"
    local match_count="$2"
    local result_msg="$3"

    {
        echo "====="
        echo "Date: $(date)"
        echo "Player: $player_name"
        echo "Player numbers:"
        cat player_numbers.txt
        echo "Lottery numbers:"
        cat lottery_numbers.txt
        echo "Matches: $match_count"
        echo "Result: $result_msg"
    } >> results.txt
}
