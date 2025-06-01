#!/bin/bash

STATE_FILE="$HOME/.cache/theme_state"
CURRENT_STATE=$(cat "$STATE_FILE" 2>/dev/null)

LIGHT_BG=$(find "$HOME/Pictures/Wallpapers/Day" -type f \( -iname '*.jpg' -o -iname '*.png' \) | head -n 1)
DARK_BG=$(find "$HOME/Pictures/Wallpapers/Night" -type f \( -iname '*.jpg' -o -iname '*.png' \) | head -n 1)

LOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"

set_hyprlock_bg() {
    local bg="$1"
    awk -v new_path="$bg" '
        /^\s*background\s*{/ {in_section=1}
        in_section && /^\s*path\s*=/ {$0 = "    path = " new_path; in_section=0}
        {print}
    ' "$LOCK_CONFIG" > "$LOCK_CONFIG.tmp" && mv "$LOCK_CONFIG.tmp" "$LOCK_CONFIG"
}

if [ "$CURRENT_STATE" == "day" ]; then
    set_hyprlock_bg "$LIGHT_BG"
else
    set_hyprlock_bg "$DARK_BG"
fi
