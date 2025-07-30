#!/bin/bash

set -euo pipefail

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm zoxide fzf ripgrep hyprland hyprpaper \
  waybar kitty hypridle hyprlock hyprpolkitagent wofi
yay -S --needed --noconfirm mako 