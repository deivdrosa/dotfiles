#!/bin/bash

DIR="$HOME/Downloads/iPhone"

mkdir -p "$DIR"

killall imv 2>/dev/null

# cache simples pra evitar duplicatas
declare -A opened

inotifywait -m -e close_write,moved_to "$DIR" | while read -r path action file; do

    FULL_PATH="$DIR/$file"

    # ignora se já abriu recentemente
    if [[ -n "${opened[$FULL_PATH]}" ]]; then
        continue
    fi

    # marca como aberto
    opened["$FULL_PATH"]=1

    # limpa cache depois de 2s (evita memória infinita)
    (sleep 2 && unset opened["$FULL_PATH"]) &

    sleep 0.2

    case "$FULL_PATH" in
        *.jpg|*.jpeg|*.png|*.webp|*.heic)
            [ -f "$FULL_PATH" ] && imv "$FULL_PATH" >/dev/null 2>&1 &
        ;;
    esac

done
