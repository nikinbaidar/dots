#!/usr/bin/env bash

function interactive_input() {
    local input rows cols width
    local footer="press enter to confirm · Ctrl-c to cancel · Super-z to hide"
    
    cols=$(tput cols)

    width=$((cols - 4))

    echo
    printf '%s\n' "$1" |
        fold -s -w "$width" |
        sed '1s/^/:: /; 2,$s/^/   /'

    # Footer
    rows=$(tput lines)

    tput sc
    tput cup $((rows - 2)) $(((cols - ${#footer}) / 2))
    echo -e "\e[90m${footer}\e[0m"
    tput rc

    printf '\n > '
    read -r input

    [[ -n "$input" ]] && printf '%s\n' "$input" > /tmp/interactive_input.txt
}

export -f interactive_input

st -c "st-floating" -T "Interactive User Input" \
    -n "spterm" -g 80x16 \
    sh -c "interactive_input '$1'"

if [[ -f /tmp/interactive_input.txt ]]; then
    input=$(< /tmp/interactive_input.txt)
    rm /tmp/interactive_input.txt
    echo "$input"
fi

