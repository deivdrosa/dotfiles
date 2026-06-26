#!/bin/bash

WALLPAPER_DIR="$HOME/photos/wallpaper"
LAST_FILE="/tmp/last_wallpaper_path"

# start watcher
inotifywait -m -e close_write,move,create "$WALLPAPER_DIR" | while read path action file; do

    FULL_PATH="$WALLPAPER_DIR/$file"

    # ignore invalid files
    [ -f "$FULL_PATH" ] || continue

    # prevent duplicates
    if [ -f "$LAST_FILE" ] && [ "$(cat "$LAST_FILE")" = "$FULL_PATH" ]; then
        continue
    fi

    echo "$FULL_PATH" > "$LAST_FILE"

    echo "[theme-daemon] wallpaper changed: $FULL_PATH"

    # 1. set wallpaper
    awww img "$FULL_PATH"

    sleep 0.3

    # 2. generate theme
    ~/.local/bin/theme-sync.sh

    sleep 0.3

    # 3. apply to waybar
    ~/.local/bin/apply-waybar-theme.sh

done
