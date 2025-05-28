#!/bin/bash

#                                                       888   e88 88e    dP"8 
#   ,"Y88b 888 8e   ,"Y88b  e88'888  ,"Y88b 888,8,  e88 888  d888 888b  C8b Y 
#  "8" 888 888 88b "8" 888 d888  '8 "8" 888 888 "  d888 888 C8888 8888D  Y8b  
#  ,ee 888 888 888 ,ee 888 Y888   , ,ee 888 888    Y888 888  Y888 888P  b Y8D 
#  "88 888 888 888 "88 888  "88,e8' "88 888 888     "88 888   "88 88"   8edP  

# Modo: automático (basado en sunwait) o forzado ("day"/"night")

LAT="43.36N"
LON="5.84W"

LIGHT_BG=$(find "$HOME/Pictures/Wallpapers/Day" -type f \( -iname '*.jpg' -o -iname '*.png' \) | head -n 1)
DARK_BG=$(find "$HOME/Pictures/Wallpapers/Night" -type f \( -iname '*.jpg' -o -iname '*.png' \) | head -n 1)

LOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"
STATE_FILE="$HOME/.cache/theme_state"
mkdir -p ~/.cache

# No ejecuta nada si el entorno gráfico no está preparado
[ -z "$WAYLAND_DISPLAY" ] && exit 0

# Determinar estado actual
if [ "$1" == "day" ] || [ "$1" == "night" ]; then
    CURRENT_STATE="$1"
else
    sunwait poll $LAT $LON
    if [ $? -eq 2 ]; then
        CURRENT_STATE="day"
    else
        CURRENT_STATE="night"
    fi
fi

# Leer estado anterior
PREVIOUS_STATE="unknown"
[ -f "$STATE_FILE" ] && PREVIOUS_STATE=$(cat "$STATE_FILE")

# Evitar repetir estado si no es ejecución forzada
if [ "$1" != "day" ] && [ "$1" != "night" ]; then
    [ "$CURRENT_STATE" == "$PREVIOUS_STATE" ] && exit 0
fi

# Aplicar modo claro
if [ "$CURRENT_STATE" == "day" ]; then
    echo "☼  Activating day mode"

    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme Breeze
    export GTK_THEME=Breeze

    swww img "$LIGHT_BG" --transition-type fade

    ESCAPED_LIGHT=$(printf '%s\n' "$LIGHT_BG" | sed -e 's/[\/&]/\\&/g')
    sed -i "s|^path = .*|path = $ESCAPED_LIGHT|" "$LOCK_CONFIG"

    xfconf-query -c xsettings -p /Net/ThemeName -s oomox-WorldEnd
    cp ~/.config/Code/User/settings-light.json ~/.config/Code/User/settings.json

    notify-send "☼ Day Mode"
    echo "day" > "$STATE_FILE"

# Aplicar modo oscuro
else
    echo "○  Activating night mode"

    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme Breeze-Dark
    export GTK_THEME=Breeze-Dark

    swww img "$DARK_BG" --transition-type fade
    ESCAPED_DARK=$(printf '%s\n' "$DARK_BG" | sed -e 's/[\/&]/\\&/g')
    sed -i "s|^path = .*|path = $ESCAPED_DARK|" "$LOCK_CONFIG"

    xfconf-query -c xsettings -p /Net/ThemeName -s Breeze
    cp ~/.config/Code/User/settings-dark.json ~/.config/Code/User/settings.json

    notify-send "☼ Night Mode"
    echo "night" > "$STATE_FILE"
fi
