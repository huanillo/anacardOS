#!/bin/bash

if ! pgrep -x spotify >/dev/null; then
  exit
fi

STATUS=$(playerctl --player=spotify status 2>/dev/null)
if [[ "$STATUS" == "Playing" ]]; then
    ICON="󰏤"  # Pause
else
    ICON="󰐊"  # Play
fi

echo "{\"text\": \"$ICON\", \"tooltip\": \"Play/Pause\"}"
