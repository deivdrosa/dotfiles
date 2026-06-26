#!/bin/bash

LAST=""

while true; do

    # get current wallpaper safely
    CURRENT=$(awww query | grep -oP 'image:\s*\K.*')

    # safety checks
    if [ -z "$CURRENT" ] || [ ! -f "$CURRENT" ]; then
        sleep 2
        continue
    fi

    # detect change
    if [ "$CURRENT" != "$LAST" ]; then
        echo "[theme-daemon] new wallpaper: $CURRENT"

        # generate theme
        ~/.local/bin/theme-sync.sh

        # wait until JSON is valid (prevents jq crash)
        THEME="$HOME/.config/dynamic-theme/colors.json"

        for i in {1..10}; do
            jq empty "$THEME" 2>/dev/null && break
            sleep 0.2
        done

        # apply waybar theme
        ~/.local/bin/apply-waybar-theme.sh

        LAST="$CURRENT"
    fi

    sleep 2
done
