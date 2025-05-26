#                                                       888   e88 88e    dP"8 
#   ,"Y88b 888 8e   ,"Y88b  e88'888  ,"Y88b 888,8,  e88 888  d888 888b  C8b Y 
#  "8" 888 888 88b "8" 888 d888  '8 "8" 888 888 "  d888 888 C8888 8888D  Y8b  
#  ,ee 888 888 888 ,ee 888 Y888   , ,ee 888 888    Y888 888  Y888 888P  b Y8D 
#  "88 888 888 888 "88 888  "88,e8' "88 888 888     "88 888   "88 88"   8edP  
  

#!/bin/bash

# TimeZone Coordinates
LAT="43.36N"
LON="5.84W"

# Wallpapers
LIGHT_BG="$HOME/Pictures/Wallpapers/806821.png"
DARK_BG="$HOME/Pictures/Wallpapers/fondo_noche.jpg"

STATE_FILE="$HOME/.cache/theme_state"
mkdir -p ~/.cache

if sunwait sun up $LAT $LON; then
    CURRENT_STATE="day"
else
    CURRENT_STATE="night"
fi

PREVIOUS_STATE="unknown"
[ -f "$STATE_FILE" ] && PREVIOUS_STATE=$(cat "$STATE_FILE")

echo "$CURRENT_STATE" > "$STATE_FILE"

[ "$CURRENT_STATE" == "$PREVIOUS_STATE" ] && exit 0


if [ "$CURRENT_STATE" == "day" ]; then
    echo "☼  Es de día, activando modo claro"

    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    gsettings set org.gnome.desktop.interface gtk-theme Breeze
    export GTK_THEME=Breeze

    swww img "$LIGHT_BG" --transition-type grow
    xfconf-query -c xsettings -p /Net/ThemeName -s oomox-WorldEnd

    cp ~/.config/Code/User/settings-light.json ~/.config/Code/User/settings.json

    notify-send "☼ Modo claro activado" "Fondo y tema actualizados"
else
    echo "○  Es de noche, activando modo oscuro"

    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    gsettings set org.gnome.desktop.interface gtk-theme Breeze-Dark
    export GTK_THEME=Breeze-Dark

    swww img "$DARK_BG" --transition-type grow
    xfconf-query -c xsettings -p /Net/ThemeName -s Breeze

    cp ~/.config/Code/User/settings-dark.json ~/.config/Code/User/settings.json

    notify-send "○ Modo oscuro activado" "Fondo y tema actualizados"
fi
