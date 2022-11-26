#!/bin/sh
# xrandr --output eDP-1 --mode 1368x768 --pos 0x0 --rotate normal --output DP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-1 --off
xrandr --output eDP-1 --mode 1368x768 --pos 0x0 --rotate normal \
  --output DP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal
cb
