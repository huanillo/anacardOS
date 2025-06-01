#!/bin/bash

#                                                       888   e88 88e    dP"8 
#   ,"Y88b 888 8e   ,"Y88b  e88'888  ,"Y88b 888,8,  e88 888  d888 888b  C8b Y 
#  "8" 888 888 88b "8" 888 d888  '8 "8" 888 888 "  d888 888 C8888 8888D  Y8b  
#  ,ee 888 888 888 ,ee 888 Y888   , ,ee 888 888    Y888 888  Y888 888P  b Y8D 
#  "88 888 888 888 "88 888  "88,e8' "88 888 888     "88 888   "88 88"   8edP  

LOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"
LAT="43.36N"
LON="5.84W"
STATE_FILE="$HOME/.cache/theme_state"
mkdir -p ~/.cache

LIGHT_BG=$(find "$HOME/Pictures/Wallpapers/Day" -type f \( -iname '*.jpg' -o -iname '*.png' \) | head -n 1)
DARK_BG=$(find "$HOME/Pictures/Wallpapers/Night" -type f \( -iname '*.jpg' -o -iname '*.png' \) | head -n 1)

[ -z "$WAYLAND_DISPLAY" ] && exit 0

if [[ "$1" == "day" || "$1" == "night" ]]; then
    CURRENT_STATE="$1"
else
    sunwait poll "$LAT" "$LON"
    CURRENT_STATE=$([[ $? -eq 2 ]] && echo "day" || echo "night")
fi

# Avoid repeating state
[ "$1" != "day" ] && [ "$1" != "night" ] && [ "$CURRENT_STATE" == "$(cat "$STATE_FILE" 2>/dev/null)" ] && exit 0

reload_dunst() {
    killall dunst 2>/dev/null
    dunst & disown
    for _ in {1..10}; do
        dbus-send --session --dest=org.freedesktop.Notifications \
        --type=method_call /org/freedesktop/Notifications \
        org.freedesktop.Notifications.GetServerInformation >/dev/null 2>&1 && break
        sleep 0.3
    done
}

set_hyprlock_bg() {
    local bg="$1"
    awk -v new_path="$bg" '
        /^\s*background\s*{/ {in_section=1}
        in_section && /^\s*path\s*=/ {$0 = "    path = " new_path; in_section=0}
        {print}
    ' "$LOCK_CONFIG" > "$LOCK_CONFIG.tmp" && mv "$LOCK_CONFIG.tmp" "$LOCK_CONFIG"
}

if [ "$CURRENT_STATE" == "day" ]; then
    echo "☼ Activating Day Mode"
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-latte-flamingo-standard+default"
    xfconf-query -c xsettings -p /Net/ThemeName -s "catppuccin-latte-flamingo-standard+default"
    export GTK_THEME="catppuccin-latte-flamingo-standard+default"

    swww img "$LIGHT_BG" --transition-type fade
    set_hyprlock_bg "$LIGHT_BG"
    killall hyprlock 2>/dev/null

    cp ~/.config/Code/User/settings-light.json ~/.config/Code/User/settings.json
    iconv -f utf-8 -t utf-8 -c ~/.config/dunst/dunstrc-day | dos2unix > ~/.config/dunst/dunstrc
    reload_dunst
    dunstify -a "Theme switch" "☼ Day Mode"
    echo "day" > "$STATE_FILE"
else
    echo "○ Activating Night Mode"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme "catppuccin-mocha-red-standard+default"
    xfconf-query -c xsettings -p /Net/ThemeName -s "catppuccin-mocha-red-standard+default"
    export GTK_THEME="catppuccin-mocha-red-standard+default"

    swww img "$DARK_BG" --transition-type fade
    set_hyprlock_bg "$DARK_BG"
    killall hyprlock 2>/dev/null

    cp ~/.config/Code/User/settings-dark.json ~/.config/Code/User/settings.json
    iconv -f utf-8 -t utf-8 -c ~/.config/dunst/dunstrc-night | dos2unix > ~/.config/dunst/dunstrc
    reload_dunst
    dunstify -a "Theme switch" "○ Night Mode"
    echo "night" > "$STATE_FILE"
fi
