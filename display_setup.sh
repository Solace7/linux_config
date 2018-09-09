#!/bin/sh
if [ `xrandr --query | grep '\bconnected\b' | wc --lines` > 1 ]; then 
#    `xrandr --output DP-0 --auto --left-of eDP-1-1 --output eDP-1-1 --primary --auto`
    `xrandr --output HDMI-0 --auto --left-of eDP-1-1 --output eDP-1-1 --primary --auto`
    #res-polybar
else
    `xrandr --output eDP-1-1 --primary --auto --output HDMI-0 --off`
fi
