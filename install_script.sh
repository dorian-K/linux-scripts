#!/bin/bash

set -euo pipefail

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm zoxide fzf ripgrep hyprland hyprpaper \
  waybar kitty hypridle hyprlock hyprpolkitagent wofi brightnessctl wireplumber pavucontrol hyprshot \
  gnome-keyring network-manager-applet
yay -S --needed --noconfirm mako 
