#!/bin/bash

WALLPAPER_DIR="$HOME/photos/wallpaper"

while true; do
  FILE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

  awww img "$FILE"

  sleep 3600
done
