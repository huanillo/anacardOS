# AnacardOS

**AnacardOS** is a custom Hyprland desktop setup designed for Arch-based systems. It combines minimalism with practicality, offering a dynamic user interface that adapts to day and night cycles. The entire configuration is managed through a single setup script.

---

## Prerequisites

- Arch Linux (or compatible)
- Hyprland **already installed and configured**

---

## What does the setup include?
The script copies all configuration files, sets up the day/night theme switching timer and installs the following packages:

- `yay`: only if it is not installed (Asks user before installing it)
- `kitty`: terminal
- `waybar`: status bar config and style.css
- `rofi`: application launcher with transparency
- `cava`: terminal audio visualizer
- `swww`: wallpaper manager with transition effects
- `meowfetch` (and `neofetch`): system info display. AnacardOS defaults to meowfetch.
- `spicetify`: Spotify UI customization
- `code` (Visual Studio Code): preconfigured with light/dark themes
- `sunwait`: sunrise/sunset detection
- `gsimplecal`: popup calendar
- `qt5ct`, `xsettingsd`: QT theming support
- `xfce4-settings`: ensures GTK theme compliance in Thunar
- `xdotool`, `libnotify`: auxiliary scripting tools
- `themix`: optional GTK theme editor
- `htop`: proccess viewer

---

## Installation

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

