#!/bin/bash

echo "AnacardOS - by Eructo"

BASE_DIR="$(pwd)"

mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/kitty
mkdir -p ~/.config/scripts
mkdir -p ~/.config/Code/User
mkdir -p ~/.themes
mkdir -p ~/Pictures/Wallpapers

cp "$BASE_DIR/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
cp "$BASE_DIR/hypr/hypridle.conf" ~/.config/hypr/hypridle.conf
cp "$BASE_DIR/hypr/hyprlock.conf" ~/.config/hypr/hyprlock.conf
cp "$BASE_DIR/kitty/kitty.conf" ~/.config/kitty/kitty.conf
cp "$BASE_DIR/rofi/config.rasi" ~/.config/rofi/config.rasi
cp "$BASE_DIR/waybar/config" ~/.config/waybar/config
cp "$BASE_DIR/waybar/style.css" ~/.config/waybar/style.css
cp "$BASE_DIR/.themes/"* ~/.themes/
cp "$BASE_DIR/scripts/"* ~/.config/scripts/
chmod +x ~/.config/scripts/*.sh
cp "$BASE_DIR/vscode/"* ~/.config/Code/User/

cp "$BASE_DIR/wallpapers/"* ~/Pictures/Wallpapers/

cp "$BASE_DIR/systemd/user/theme-sun-switch."* ~/.config/systemd/user/
systemctl --user daemon-reexec
systemctl --user enable --now theme-sun-switch.timer

if ! command -v yay &> /dev/null; then
    echo "Yay is not installed. Do you want to install it now? (y/n)"
    read -r install_yay
    if [[ "$install_yay" == "y" || "$install_yay" == "s" ]]; then
        sudo pacman -S --noconfirm --needed git base-devel
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        cd /tmp/yay || exit
        makepkg -si --noconfirm
        cd "$BASE_DIR" || exit
    else
        echo "Yay is required to install some packages. Exiting."
        exit 1
    fi
fi

echo "Install all  needed packages? (y/n)"
read -r install
if [[ "$install" == "s" || "$install" == "y" ]]; then
  sudo pacman -S --noconfirm --needed kitty rofi waybar cava gsimplecal xdotool swww neofetch qt5ct xsettingsd xfce4-settings libnotify htop

  yay -S --noconfirm spicetify meowfetch sunwait visual-studio-code-bin themix
fi

echo "AnacardOS installed. Reboot Hyprland."
