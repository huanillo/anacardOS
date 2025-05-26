# AnacardOS

**AnacardOS** is a custom Hyprland desktop setup designed for Arch-based systems. It combines minimalism with practicality, offering a dynamic user interface that adapts to day and night cycles. The entire configuration is managed through a single setup script.

---

## Prerequisites

- Arch Linux (or compatible)
- Hyprland **already installed and configured**
- Yay

---

## What does the setup include?

The script installs and configures the following tools and dependencies:

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

---

## Installation

```bash
git clone https://github.com/eructo/anacardOS ~/.anacardOS
cd ~/.anacardOS
chmod +x setup.sh
./setup.sh
```

During installation, you will be prompted to install all required packages using `yay`. Make sure `yay` is available on your system.

---

## Day/Night Theme Automation

The setup includes a systemd timer (`theme-sun-switch.timer`) that automatically switches between light and dark themes based on the sunrise and sunset times in Asturias (by default). You can customize the behavior in the script located at:

```bash
~/.config/scripts/theme-sun-switch.sh
```

---
