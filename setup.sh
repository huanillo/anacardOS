#!/bin/bash

set -e

echo "AnacardOS - by Eructo"

BASE_DIR="$(pwd)"

### Create config folders
mkdir -p ~/.config/{hypr,waybar,rofi,kitty,scripts,Code/User} ~/.themes ~/Pictures/Wallpapers ~/.icons

### Copy configs
cp "$BASE_DIR/hypr/"*.conf ~/.config/hypr/
cp "$BASE_DIR/kitty/kitty.conf" ~/.config/kitty/
cp "$BASE_DIR/rofi/config.rasi" ~/.config/rofi/
cp "$BASE_DIR/waybar/config" ~/.config/waybar/
cp "$BASE_DIR/waybar/style.css" ~/.config/waybar/
cp -r "$BASE_DIR/.themes/"* ~/.themes/
cp -r "$BASE_DIR/.icons/"* ~/.icons/ 2>/dev/null || true
cp "$BASE_DIR/scripts/"* ~/.config/scripts/
chmod +x ~/.config/scripts/*.sh
cp "$BASE_DIR/vscode/"* ~/.config/Code/User/
cp "$BASE_DIR/wallpapers/"* ~/Pictures/Wallpapers/

### Setup theme-switch service
cp "$BASE_DIR/systemd/user/theme-sun-switch."* ~/.config/systemd/user/
systemctl --user daemon-reexec
systemctl --user enable --now theme-sun-switch.timer

### Install yay if missing
if ! command -v yay &> /dev/null; then
  echo "Yay is not installed. Do you want to install it now? (y/n)"
  read -r install_yay
  if [[ "$install_yay" =~ ^[yYsS]$ ]]; then
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd "$BASE_DIR"
  else
    echo "Yay is required to install some packages. Exiting."
    exit 1
  fi
fi

### Install packages
echo "Install all needed packages? (y/n)"
read -r install
if [[ "$install" =~ ^[yYsS]$ ]]; then
  sudo pacman -S --noconfirm --needed \
    kitty rofi waybar cava gsimplecal \
    xdotool swww qt5ct xsettingsd \
    xfce4-settings libnotify htop \
    pacman-contrib brightnessctl playerctl \
    wl-clipboard

  yay -S --noconfirm \
    spicetify sunwait visual-studio-code-bin themix
fi

### Install meowfetch
if [ ! -d /tmp/meowfetch ]; then
  git clone https://github.com/huanillo/meowfetch.git /tmp/meowfetch
  cd /tmp/meowfetch && make && sudo make install
  cd "$BASE_DIR"
fi

### Ask for coordinates
echo "Configure location for day/night theme switching. Leave empty for default (Asturias, Spain)"
read -p "Enter your latitude (e.g., 43.36N): " LAT
read -p "Enter your longitude (e.g., 5.84W): " LON
LAT=${LAT:-43.36N}
LON=${LON:-5.84W}

sed -i "s/^LAT=.*/LAT=\"$LAT\"/" ~/.config/scripts/theme-sun-switch.sh
sed -i "s/^LON=.*/LON=\"$LON\"/" ~/.config/scripts/theme-sun-switch.sh

echo "\nAnacardOS installed. Reboot Hyprland or relogin to apply changes."
