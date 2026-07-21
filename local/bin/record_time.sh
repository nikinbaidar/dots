#!/usr/bin/env bash

# Capture the current time
now=$(date +%s)

function format_time() {
    minutes=$(( $1 / 60 ))
    seconds=$(( $1 % 60 ))
    echo ${minutes}m ${seconds}s
}


if [[ -f /tmp/now.datetime ]]; then
    # Calculate the difference between the current time and 
    # the time logged in /tmp/now.datetime and then clear the log.
    timediff=$(( $now - $(< /tmp/now.datetime) ))
    timediff_formatted=$(format_time $timediff)
    dm -msg "Reading completed in $timediff_formatted" -d 6
    logs=$(interactive_input.sh "Reading completed in $timediff_formatted.\nEnter details: Page,Chapter,Selection,WPM")
    echo "$(date +'%F'),${logs%,*},${timediff_formatted},${logs##*,}" >> ~/notes/Extras/readingspeed.csv
    rm /tmp/now.datetime
else
    dm -msg "Begin reading"
    # Log the current time
    echo -n "$now" > /tmp/now.datetime
fi
