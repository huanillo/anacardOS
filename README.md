#
             ▌▄▖▄▖
▀▌▛▌▀▌▛▘▀▌▛▘▛▌▌▌▚ 
█▌▌▌█▌▙▖█▌▌ ▙▌▙▌▄▌
                  
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Made for Arch](https://img.shields.io/badge/made%20for-ArchLinux-blue)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-ff69b4)

My custom rice. It adapts to day/night cycles based on coordinates. The entire configuration is managed through a single setup script.

---

## Prerequisites

- Arch Linux (or compatible)
- Hyprland

---

## What does the setup include?
The script copies all configuration files, sets up the day/night theme switching timer and installs the following packages:

### System Components
- `kitty`: Terminal emulator
- `waybar`: Status bar with custom styling and modules
- `rofi`: Application launcher with transparency
- `cava`: Terminal audio visualizer
- `swww`: Wallpaper manager with transition effects
- `meowfetch`: System info fetcher (custom fork identifying AnacardOS)
- `code` (Visual Studio Code): Preconfigured with matching light/dark themes (customizable)

### Theme and Automation
- `sunwait`: Detects sunrise/sunset for auto theme switching
- `qt5ct`, `xsettingsd`: QT theming support
- `xfce4-settings`: Ensures GTK compliance in Thunar
- `themix`: Optional GTK theme editor (manual usage)

### Utilities & UX
- `gsimplecal`: Clickable popup calendar
- `xdotool`, `libnotify`: Auxiliary scripting and notifications
- `htop`: Process viewer
- `pacman-contrib`: Enables `checkupdates` for system update checks
- `playerctl`: Spotify media controls (Waybar integration)
- `blueman`, `bluez`, `bluez-utils`: Bluetooth management
- `pavucontrol`: Audio control GUI
- `grimblast`: Screenshot utility
- `brightnessctl`: Brightness adjustment
- `wl-clipboard`: Clipboard support for Wayland
- `xdg-desktop-portal-hyprland`: Fixes some Wayland-related issues
- `ttf-jetbrains-mono-nerd`, `papirus-icon-theme`: Fonts and icons

### AUR helper
- `yay`: Only installed if not present (user confirmation required)


---

## Installation

If you want to use the setup script:

```bash
git clone https://github.com/eructo/anacardOS ~/.anacardOS
cd ~/.anacardOS
chmod +x setup.sh
./setup.sh
```

During installation, you will be prompted to enter a latitude and longitude to configure the day/night automation. Leave both empty to use the default value (Asturias, España).
This coordinates and other behaviours of the automation can be customized in the script located at:

```bash
~/.config/scripts/theme-sun-switch.sh
```

---

## Usage

You can change your wallpapers anytime saving it in ~/Pictures/Wallpapers/Day or ../Night respectively, only .png format if you want it to work with hyprlock also.

VScode and Thunar preferred themes can be modified in the theme switching script (theme-sun-switch.sh).