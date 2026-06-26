#!/bin/bash

ws=$(hyprctl activeworkspace -j | jq '.id')

if [ "$ws" -eq 4 ]; then
    pkill waybar
else
    pgrep waybar >/dev/null || waybar &
fi
