#!/bin/sh
if [ `xrandr --query | grep '\bconnected\b'` | `wc --lines` > 1 ]; then 
    `xrandr --output eDP-1-1 --auto --left-of DP-0`
else
    `xrandr --output DP-0 --primary --auto`
fi
