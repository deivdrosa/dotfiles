#!/usr/bin/env bash

# nome da janela do blueman
WIN="blueman-manager"

# se já existir janela aberta → fecha
if pgrep -f blueman-manager >/dev/null; then
    pkill -f blueman-manager
    exit 0
fi

# se não existir → abre
blueman-manager &
