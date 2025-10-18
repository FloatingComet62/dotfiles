#!/usr/bin/env bash

echo "Inserting files..."
mkdir -p ~/.config
sudo cp -r hypr foot nvim tmux waybar wofi yazi starship.toml ~/.config
sudo cp -r Wallpapers ~/Pictures

# Although we are sending the configs to /etc/nixos, we aren't actually using them with the flake setup
# Consider the operation purely for vanity
sudo cp -r nixos /etc
sudo cp -r hardware-configuration.nix /etc/nixos

sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix

sudo nixos-rebuild switch --flake .#main
