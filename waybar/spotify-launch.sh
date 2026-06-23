#!/bin/bash

WS="special:spotify"
SPOTIFY="/usr/bin/spotify"

# 1. sempre abre/foca workspace primeiro
hyprctl dispatch togglespecialworkspace spotify

# 2. pequeno delay só pra garantir foco do Hyprland
sleep 0.2

# 3. só abre Spotify se não estiver rodando
if ! pgrep -x spotify >/dev/null; then
    "$SPOTIFY" & disown
fi
