#!/usr/bin/env bash

echo "Inserting files..."
sudo cp -r Wallpapers ~/Pictures

find . -type f -name "*.sh" -print -exec chmod +x {} \;

echo "Rebuilding..."
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
sudo nixos-rebuild switch --flake .#main

strfile ~/.config/fortune/showerthoughts
