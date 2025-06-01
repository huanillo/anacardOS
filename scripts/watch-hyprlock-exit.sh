#!/bin/bash

while pgrep hyprlock >/dev/null; do sleep 1; done
~/.config/scripts/update-hyprlock-bg.sh
