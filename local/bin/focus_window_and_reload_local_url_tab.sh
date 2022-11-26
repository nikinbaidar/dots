#!/bin/sh

: "
* Make sure there is only a single *.default-release else you might have to
alter the FF_SESSION path below.
* This script will for some reason reload the last tab that you have visited.
I don't know why this behaviour occurs.
"


FF_SESSION=${HOME}/.mozilla/firefox/*.default-release/sessionstore-backups/recovery.jsonlz4

if [ -f ${FF_SESSION} ] && [ -f /tmp/localFilename ];  then
  tab_position=$(get_tab_position.py "$(cat /tmp/localFilename)")
  if [ "${tab_position}" != "None" ]; then
    xdotool key --clearmodifiers --window 12582956 Alt+${tab_position}
    xdotool key --clearmodifiers --window 12582956 F5
  fi
else
  echo "error: either firefox isn't running or /tmp/localFilename doesn't exist."
fi
