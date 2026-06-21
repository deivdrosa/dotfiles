#!/bin/bash

if ! playerctl status 2>/dev/null; then
  echo "Sem música"
  exit
fi

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

if [ -z "$TITLE" ]; then
  echo "Sem música"
else
  echo "$ARTIST - $TITLE"
fi
