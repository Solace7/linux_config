#!/bin/bash
i3lock -i $HOME/lock.png \
    -S=0  \
    -B 15 \
    --clock \
    --ringvercolor=ffd700ff \
    --keyhlcolor=ffffffff \
    --bar-indicator \
    --bar-base-width=10 \
    --bar-max-height=5 \
    --bar-direction=2 \
    --bar-color=1f1f1fff \
    --bar-position=1090 \
    --timestr="" \
    --datestr="%H:%M:%S | %Y-%m-%d" \
    --datepos="1020:900" \
    --date-font="Fira Code" \
    --time-font="Fira Code" \
    --datecolor=ffffffff \
    --datesize=20
