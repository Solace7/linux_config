#!/bin/bash

pscircle \
    --background-image=/home/sgreyowl/wallpaper.png \
    --tree-center=0:0 \
    --cpulist-center=550:0 \
    --memlist-center=550:250 \
    --toplists-bar-height=7 \
    --toplists-row-height=30 \
    --max-children=5 \
    --collapse-threads=true \
    --tree-radius-increment=100 \
    --output-width=1920 \
    --output-height=1080 \
    --dot-color-min=FC0 \
    --link-color-min=caa \
    --tree-font-face="Fantasque Sans Mono" \
    --toplists-font-face="Fantasque Sans Mono" \
    --output=/home/sgreyowl/pscircle.png
#    --output-display=eDP-1-1 

feh --bg-fill ~/pscircle.png
