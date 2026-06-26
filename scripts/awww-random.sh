#!/bin/bash

WALLPAPER_DIR="$HOME/photos/wallpaper"

FILE=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

awww img "$FILE"
