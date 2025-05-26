#!/bin/bash

# Nivel mínimo antes de dar el toque
LOW_LEVEL=15

# Obtenemos porcentaje
battery_level=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

# Si está descargando y bajo el umbral
if [[ "$battery_level" -le "$LOW_LEVEL" && "$status" == "Discharging" ]]; then
    notify-send -u critical "Batería baja" "Te queda ${battery_level}%"
fi
