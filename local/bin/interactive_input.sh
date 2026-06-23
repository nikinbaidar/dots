#!/usr/bin/env bash

function interactive_input() {
    local prompt="${1:-Enter value}"
    local w=70
    local x=4
    local y=3
    local hr=$(printf '─%.0s' $(seq 1 $w))
    local title="── Interactive User Input ──"
    local hint="press enter to confirm · Ctrl-c to cancel"
    local max_prompt=$((w - 4))

    # Word-wrap prompt into lines
    local wrapped=()
    local line=""
    for word in $prompt; do
        if (( ${#line} + ${#word} + 1 > max_prompt )); then
            wrapped+=("$line")
            line="$word"
        else
            line="${line:+$line }$word"
        fi
    done
    [[ -n "$line" ]] && wrapped+=("$line")

    local prompt_lines=${#wrapped[@]}
    local h=$(( prompt_lines + 3 ))  # padding + input row

    tput clear
    tput civis

    # Title
    local title_x=$(( x + (w / 2) - (${#title} / 2) ))
    tput cup $((y-2)) $title_x; echo -e "\e[90m${title}\e[0m"

    # Box
    tput cup $y $x; echo -e "\e[90m┌${hr}┐\e[0m"
    for ((i=1; i<=h; i++)); do
        tput cup $((y+i)) $x; echo -e "\e[90m│$(printf ' %.0s' $(seq 1 $w))│\e[0m"
    done
    tput cup $((y+h+1)) $x; echo -e "\e[90m└${hr}┘\e[0m"

    # Prompt lines
    for ((i=0; i<prompt_lines; i++)); do
        tput cup $((y+1+i)) $((x+2)); echo -e "\e[32m${wrapped[$i]}\e[0m"
    done

    # Input row
    local input_row=$((y + prompt_lines + 2))
    tput cup $input_row $((x+2)); echo -e "\e[90m›\e[0m"

    # Hint
    local hint_x=$(( x + (w / 2) - (${#hint} / 2) ))
    tput cup $((y+h+3)) $hint_x; echo -e "\e[90m${hint}\e[0m"

    # Cursor and read
    tput cup $input_row $((x+4))
    tput cnorm
    read -r input

    tput clear
    echo "$input" > /tmp/interactive_input.txt
}
export -f interactive_input

st -c "Interactive User Input" -T "Interactive User Input" \
    sh -c "interactive_input '$1'"

if [[ -f /tmp/interactive_input.txt ]]; then
    input=$(< /tmp/interactive_input.txt)
    rm /tmp/interactive_input.txt
    echo "$input"
fi


