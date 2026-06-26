#!/bin/bash

# toggle floating
hyprctl dispatch togglefloating

# espera aplicar
sleep 0.05

# pega tamanho da tela atual via hyprctl
read W H <<< $(hyprctl monitors -j | jq -r '.[0] | "\(.width) \(.height)"')

# calcula 1/4 da tela
WW=$((W / 2))
HH=$((H / 2))

# aplica tamanho
hyprctl dispatch resizeactive exact $WW $HH

# move pra canto superior esquerdo
hyprctl dispatch movewindow exact 0 0
