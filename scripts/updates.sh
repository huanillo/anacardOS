#!/bin/bash

PACMAN_COUNT=$(checkupdates 2>/dev/null | wc -l)
AUR_COUNT=$(yay -Qua 2>/dev/null | wc -l)
TOTAL=$((PACMAN_COUNT + AUR_COUNT))

if [[ $TOTAL -gt 0 ]]; then
    echo "{\"text\": \"⬆ $TOTAL\", \"tooltip\": \"$PACMAN_COUNT del sistema y $AUR_COUNT de AUR\", \"class\": \"updates-available\"}"
else
    echo ""
fi
