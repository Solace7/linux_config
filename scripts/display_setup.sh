#!/bin/sh
killall -9 conky > /dev/null

if [ `xrandr --query | grep '\bconnected\b' | wc --lines` > 1 ]; then 
    `xrandr --output HDMI-0 --primary --auto --right-of eDP-1-1 --output eDP-1-1 --auto`
    `conky -x 1920 -c "$HOME/.config/conky/todo.conf"`
else
    `xrandr --output eDP-1-1 --primary --auto --output HDMI-0 --off`
    `conky -c "$HOME/.config/conky/todo.conf"`
    `notify-send SingleMonitorMode`
fi

#res-polybar
