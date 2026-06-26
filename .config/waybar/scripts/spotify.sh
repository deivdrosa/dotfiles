#!/bin/bash

STATUS=$(playerctl status 2>/dev/null)

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

# limpa espaços/lixo
TEXT="${ARTIST} - ${TITLE}"
TEXT=$(echo "$TEXT" | sed 's/^ - //;s/^- //')

if [ -z "$TITLE" ]; then
  echo "Sem música"
else
  echo "$TEXT"
fi

