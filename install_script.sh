#!/bin/bash

set -euo pipefail

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm zoxide fzf ripgrep hyprland hyprpaper hyprlauncher \
  waybar kitty hypridle hyprlock hyprpolkitagent wofi brightnessctl wireplumber pavucontrol hyprshot \
  gnome-keyring network-manager-applet bc dunst hyprpicker

install -Dm755 misc/aur-llm-review ~/.local/bin/aur-llm-review

yay --save --answerdiff=All --version
yay -S --needed --noconfirm mako

