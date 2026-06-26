#!/bin/bash

mkdir -p ~/.config/dynamic-theme

# get current wallpaper safely
WALLPAPER=$(awww query | grep -oP 'image:\s*\K.*')

# fallback if empty
if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    WALLPAPER=$(find ~/photos/wallpaper -type f | shuf -n 1)
fi

# safety check
if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    echo "[theme-sync] no valid wallpaper found"
    exit 1
fi

echo "[theme-sync] generating theme from: $WALLPAPER"

# generate theme (correct matugen usage)
matugen image "$WALLPAPER" \
  --source-color-index 0 \
  --prefer lightness
