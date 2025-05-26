
## 📦 Requisitos previos

- Arch Linux (o derivada)
- Hyprland **ya instalado**

## 🔧 ¿Qué instala este setup?

El script configurará todo lo siguiente:

- `kitty`: terminal
- `waybar`: barra de estado
- `rofi`: launcher con transparencia
- `cava`: visualizador de audio
- `swww`: cambio de wallpapers con transición
- `meowfetch` o `neofetch`: banner de sistema
- `spicetify`: para tunear Spotify
- `code` (VS Code): ya configurado
- `sunwait`: detección solar para cambiar tema
- `gsimplecal`: calendario emergente
- `qt5ct`, `xsettingsd`: para temas QT
- `xfce4-settings`: para que Thunar respete GTK
- `xdotool`, `libnotify`: para scripts auxiliares
- `themix`: editor de temas GTK (opcional)

## 🛠 Instalación

```bash
git clone https://github.com/eructo/anacardOS ~/.anacardOS
cd ~/.anacardOS
chmod +x setup.sh
./setup.sh
```

Durante la instalación, puedes optar por instalar todos los paquetes necesarios usando `yay`.

## 🌗 Cambio automático de tema día/noche

Activado con `theme-sun-switch.timer`, según salida/puesta del sol en Asturias.  
Se puede personalizar en el archivo `scripts/theme-sun-switch.sh`.

