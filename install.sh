#!/usr/bin/env bash

echo "Inserting files..."
mkdir -p ~/.config
sudo cp -r hypr foot nvim tmux waybar wofi yazi home-manager starship.toml ~/.config
sudo cp -r Wallpapers ~/Pictures

sudo cp -r nixos /etc
sudo nixos-generate-config

CHANNEL_FILE="nixos/nix-channel.txt"
if [[ ! -f "$CHANNEL_FILE" ]]; then
    echo "Error: Channel file not found at $CHANNEL_FILE"
    exit 1
fi
current_channels=$(sudo nix-channel --list)

# Read and process each channel from file
while IFS= read -r line || [[ -n "$line" ]]; do
    # Skip empty lines and comments
    [[ -z "$line" ]] || [[ "$line" =~ ^[[:space:]]*# ]] && continue
    
    # Parse channel name and URL (format: "name url")
    channel_name=$(echo "$line" | awk '{print $1}')
    channel_url=$(echo "$line" | awk '{print $2}')
    
    # Check if channel already exists
    if echo "$current_channels" | grep -q "^$channel_name "; then
        echo "✓ Channel '$channel_name' already exists"
    else
        echo "Adding channel '$channel_name' from $channel_url"
        sudo nix-channel --add "$channel_url" "$channel_name"
    fi
done < "$CHANNEL_FILE"

# Update channels after adding new ones
echo "Updating channels..."
sudo nix-channel --update

echo "Switching..."
sudo nixos-rebuild switch
home-manager switch

