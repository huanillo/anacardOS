#!/bin/bash

if ! pgrep -x spotify >/dev/null; then
  exit
fi

echo '{"text": "󰒮", "tooltip": "Anterior"}'
