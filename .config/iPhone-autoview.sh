#!/bin/bash

DIR="$HOME/Downloads/iPhone"

inotifywait -m "$DIR" -e close_write,moved_to |
while read path action file; do
    case "$file" in
        *.jpg|*.jpeg|*.png|*.webp|*.gif)
            xdg-open "$DIR/$file"
        ;;
    esac
done
