#!/bin/bash

WALLPAPER=$(awww query 2>/dev/null | head -n 1)

# fallback
if [ -z "$WALLPAPER" ]; then
  WALLPAPER=$(find ~/photos/wallpapers -type f | shuf -n 1)
fi

# run matugen correctly
matugen image "$WALLPAPER"
