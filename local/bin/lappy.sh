#!/bin/sh

intern=eDP-1
extern=DP-1
xrandr --output ${intern} --primary --pos 0x0 --rotate normal \
    --output ${extern} --off
cb ${HOME}/pics/wallpapers/black-pixelated.jpg
