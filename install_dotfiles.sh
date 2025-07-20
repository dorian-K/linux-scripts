#!/bin/bash

link_dotfile() {
	local home_rel_path="$1"
	local local_rel_path="${2:-dotfiles/$1}"
	local home_abs_path="$HOME/$home_rel_path"
	local local_abs_path="$(cd "$(dirname "$0")" && pwd)/$local_rel_path"

	if [ ! -e "$local_abs_path" ]; then
		echo "Local path $local_abs_path does not exist. Skipping."
		return
	fi
	if [ ! -e "$home_abs_path" ]; then
		ln -s "$local_abs_path" "$home_abs_path"
		echo "Symlinked $local_abs_path to $home_abs_path"
	else
		echo "$home_abs_path already exists, skipping."
	fi
}

link_dotfile ".zshrc"
link_dotfile ".oh-my-zsh"
link_dotfile ".oh-my-zsh-custom"

if [[ " $@ " =~ " --desktop " ]]; then
	link_dotfile ".config/hypr"
	link_dotfile ".config/waybar"
	link_dotfile ".config/kitty"
	link_dotfile ".config/mako"
fi