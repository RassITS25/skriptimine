#!/bin/bash

# Leiatakse skripti kaust, et käivitamine töötaks igalt poolt
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Laadime moodulid (source)
source "$SCRIPT_DIR/files.sh"
source "$SCRIPT_DIR/lottery_functions.sh"
source "$SCRIPT_DIR/input.sh"
source "$SCRIPT_DIR/result.sh"

# Programmi töövoog
clear_files

read_player
read_player_numbers
show_player_numbers

generate_lottery_numbers
show_lottery_numbers

check_matches
show_result "$PLAYER_NAME" "$MATCH_COUNT"
save_result "$PLAYER_NAME" "$MATCH_COUNT" "$RESULT_MSG"
