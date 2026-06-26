#!/bin/bash

SPECIAL="z"

WIN_JSON=$(hyprctl activewindow -j 2>/dev/null)

# =========================
# CASO 1: não tem janela ativa → só toggle view
# =========================
if [[ -z "$WIN_JSON" ]]; then
    hyprctl dispatch togglespecialworkspace $SPECIAL
    exit
fi

WIN_WS=$(echo "$WIN_JSON" | jq -r '.workspace.name')

# =========================
# CASO 2: janela fora do special → move pra lá
# =========================
if [[ "$WIN_WS" != "special:$SPECIAL" ]]; then
    hyprctl dispatch movetoworkspace special:$SPECIAL
    exit
fi

# =========================
# CASO 3: já está no special
# → aqui NÃO tenta inferir nada
# só toggle simples (sem workspace switch manual)
# =========================
hyprctl dispatch togglespecialworkspace $SPECIAL
