#!/bin/bash

#!/bin/bash
# Save as ~/.config/hypr/scripts/pywal-reload.sh

# Path to the image
IMAGE_PATH="$1"

# If no argument is provided, use the latest wallpaper
if [ -z "$IMAGE_PATH" ]; then
    IMAGE_PATH="$(cat ~/.cache/wal/wal)"
fi

# Generate color scheme from the wallpaper
wal -i "$IMAGE_PATH"

# Restart waybar to apply changes
killall waybar
sleep 0.5
waybar &

# Optional: reload Hyprland configs if needed
hyprctl reload
