#!/bin/bash

quarto_pid=""

start_preview() {
  quarto preview
  quarto_pid=$!
}

restart_preview() {
  if [ -n "$quarto_pid" ]; then
    kill $quarto_pid 2>/dev/null
  fi
  start_preview
}

if [[ ! -d .quarto ]] ; then
    cd ~/notes
fi

start_preview &

while true; do
  read input
  [[ $input = r ]] && restart_preview &
done
