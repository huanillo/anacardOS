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
cp -r "$BASE_DIR/.icons/"* ~/.icons/ 2>>"$BASE_DIR/error.log" || echo "Error copying icons. Check error.log for details."
cp "$BASE_DIR/scripts/"* ~/.config/scripts/
chmod +x ~/.config/scripts/*.sh
cp "$BASE_DIR/wallpapers/"* ~/Pictures/Wallpapers/

### Setup theme-switch service
cp "$BASE_DIR/systemd/user/theme-sun-switch."* ~/.config/systemd/user/
systemctl --user daemon-reexec
systemctl --user enable --now theme-sun-switch.timer

### Install yay if missing
# Check if the 'yay' command is available; if not, proceed to install it.
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
  sudo pacman -S --noconfirm --needed kitty rofi waybar cava gsimplecal xdotool swww qt5ct xsettingsd xfce4-settings libnotify htop pacman-contrib brightnessctl playerctl wl-clipboard

  yay -S --noconfirm \
    spicetify sunwait visual-studio-code-bin themix
fi

### Install custom meowfetch
  echo "Warning: Installing AUR packages may pose security risks. Proceed with caution."
  yay -S --noconfirm \
    spicetify sunwait visual-studio-code-bin themix
  cd /tmp/meowfetch && make && sudo make install
  cd "$BASE_DIR"
fi

echo "Configure location for day/night theme switching. Leave empty for default (Asturias, Spain)"
echo "Examples of valid formats: Latitude (e.g., 43.36N or 43.36), Longitude (e.g., 5.84W or -5.84)"
read -p "Enter your latitude: " LAT
read -p "Enter your longitude: " LON
read -p "Enter your longitude (e.g., 5.84W): " LON
LAT=${LAT:-43.36N}
LON=${LON:-5.84W}
if [[ -f ~/.config/scripts/theme-sun-switch.sh ]]; then
  sed -i "s/^LAT=.*/LAT=\"$LAT\"/" ~/.config/scripts/theme-sun-switch.sh
  sed -i "s/^LON=.*/LON=\"$LON\"/" ~/.config/scripts/theme-sun-switch.sh
else
  echo "theme-sun-switch.sh not found. Skipping location configuration."
fi
sed -i "s/^LON=.*/LON=\"$LON\"/" ~/.config/scripts/theme-sun-switch.sh
echo ""
echo "AnacardOS installation complete."
echo "Please restart your window manager or log out and log back in to apply changes."
