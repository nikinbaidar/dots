#!/usr/bin/env bash
# Reencode vid
ex="${2:-${1##*.}}"

ffmpeg -i "$1" \
    -vf "format=yuv420p" \
    -c:v libx264 \
    -crf 18 \
    -preset fast \
    -c:a copy \
    -b:a 128k \
    -movflags +faststart \
    output.$ex
    && mv ouput.$ex "$1"
