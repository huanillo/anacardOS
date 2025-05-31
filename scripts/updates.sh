#!/bin/bash

count=$(checkupdates 2>/dev/null | wc -l)

if [[ $count -gt 0 ]]; then
    echo "{\"text\": \" $count\", \"tooltip\": \"📦 Hay $count actualizaciones disponibles\", \"class\": \"updates-available\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"Todo actualizado\"}"
fi
