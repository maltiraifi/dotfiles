#!/bin/bash

# Usage: ./rice_switcher.sh [current|bibjaw]

PROFILE=$1

if [ -z "$PROFILE" ]; then
    echo "Usage: $0 [current|bibjaw]"
    exit 1
fi

if [ ! -d "$HOME/.config/hypr/RiceProfiles/$PROFILE" ]; then
    echo "Profile $PROFILE not found!"
    exit 1
fi

# Switch Hypr profiles
ln -sf $HOME/.config/hypr/RiceProfiles/$PROFILE/UserConfigs $HOME/.config/hypr/UserConfigs
ln -sf $HOME/.config/hypr/RiceProfiles/$PROFILE/animations $HOME/.config/hypr/animations
ln -sf $HOME/.config/hypr/RiceProfiles/$PROFILE/Monitor_Profiles $HOME/.config/hypr/Monitor_Profiles
ln -sf $HOME/.config/hypr/RiceProfiles/$PROFILE/themes $HOME/.config/hypr/themes
# Add more ln lines for other folders

# Switch Waybar if needed
ln -sf $HOME/.config/waybar/RiceProfiles/$PROFILE/configs $HOME/.config/waybar/configs
ln -sf $HOME/.config/waybar/RiceProfiles/$PROFILE/style $HOME/.config/waybar/style

# Reload
hyprctl reload
pkill waybar && waybar &  # Restart Waybar
# Optional: Restart other components like awww, hyprpaper, notifications, etc.
# e.g., awww init && ~/.config/hypr/scripts/WallpaperRandom.sh

echo "Switched to $PROFILE rice and reloaded!"
