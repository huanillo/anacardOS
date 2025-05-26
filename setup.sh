#!/bin/bash

echo "AnacardOS - by Eructo"

# Directorio actual (raíz del repo clonado)
BASE_DIR="$(pwd)"

mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/scripts
mkdir -p ~/.config/Code/User
mkdir -p ~/Pictures/Wallpapers

ln -sf "$BASE_DIR/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
ln -sf "$BASE_DIR/kitty/kitty.conf" ~/.config/kitty/kitty.conf
ln -sf "$BASE_DIR/rofi/config.rasi" ~/.config/rofi/config.rasi
ln -sf "$BASE_DIR/waybar/config" ~/.config/waybar/config
ln -sf "$BASE_DIR/waybar/style.css" ~/.config/waybar/style.css
cp "$BASE_DIR/scripts/"* ~/.config/scripts/
chmod +x ~/.config/scripts/*.sh
cp "$BASE_DIR/vscode/"* ~/.config/Code/User/

cp "$BASE_DIR/wallpapers/"* ~/Pictures/Wallpapers/

systemctl --user daemon-reexec
systemctl --user enable --now theme-sun-switch.timer

echo "Install needed packages with yay? (y/n)"
read -r install
if [[ "$install" == "s" ]]; then
  yay -S --noconfirm kitty rofi waybar cava spicetify gsimplecal xdotool swww meowfetch neofetch qt5ct xsettingsd sunwait xfce4-settings libnotify code theMix
fi

echo "AnacardOS installed. Reboot Hyprland."
