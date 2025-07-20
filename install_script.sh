#!/bin/bash

set -euo pipefail

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm zoxide fzf
yay -S --needed --noconfirm mako