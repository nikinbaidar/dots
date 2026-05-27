#!/usr/bin/env bash
ffmpeg -i $1 \
    -vf "format=yuv420p" \
    -c:v libx264 \
    -crf 18 \
    -preset fast \
    -c:a copy \
    -b:a 128k \
    -movflags +faststart \
    "fixed-$1"
