#!/usr/bin/env bash

function format_time() {
    M=$(( $1 / 60 ))
    S=$(( $1 % 60 ))
    M=$(printf "%02d" "$((M % 60))")
    S=$(printf "%02d" "$((S % 60))")
    echo ${M}:${S}
}

case $1 in
    -P)
        function display_elapsed() {
            tput civis
            elapsed=$1
            elapsed_formatted=$(format_time $elapsed)
            echo -en " \033[31m■\033[0m PAU ${elapsed_formatted}"
            read
        }

    shift
    ;;

*)
    function display_elapsed() {
        now=$(date +%s)
        tput civis
        while true; do
            elapsed=$(( $(date +%s) - $now + $1 ))
            elapsed_formatted=$(format_time $elapsed)
            # Display elapsed
            echo -en " \033[31m●\033[0m REC ${elapsed_formatted}\r"
            sleep 1
        done
    }
    ;;

esac

if [[ $1 ]]; then
    elapsed=$1
else
    elapsed=0
fi

export -f format_time 
export -f display_elapsed 

exec st -c "Display" -T "Display message" -n "REC" -z 22 \
    -g 14x1 bash -c "display_elapsed '$elapsed'"
