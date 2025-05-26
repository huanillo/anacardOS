#!/bin/bash
count=$(checkupdates 2>/dev/null | wc -l)

if [[ $count -gt 0 ]]; then
    notify-send "📦 Hay $count actualizaciones disponibles"
    echo "⬆ $count"
else
    echo "✅"
fi
