#!/usr/bin/env bash
# Hyprland rice installer for Arch Linux. Safe to re-run.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"
CFG="${XDG_CONFIG_HOME:-$HOME/.config}"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config-backup-$STAMP"

[ "$(id -u)" -ne 0 ] || { echo "Run as your normal user, not root."; exit 1; }

echo "==> Installing repo packages"
sudo pacman -Syu --needed --noconfirm - < <(grep -vE '^\s*(#|$)' "$REPO/packages/pacman.txt")

if ! command -v yay >/dev/null && ! command -v paru >/dev/null; then
  echo "==> Installing yay"
  tmp="$(mktemp -d)"; sudo pacman -S --needed --noconfirm base-devel git
  git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
  (cd "$tmp/yay-bin" && makepkg -si --noconfirm)
fi
AUR="$(command -v paru || command -v yay)"
echo "==> Installing AUR packages with $AUR"
"$AUR" -S --needed --noconfirm $(grep -vE '^\s*(#|$)' "$REPO/packages/aur.txt")

echo "==> Installing configs (existing ones backed up to $BACKUP)"
mkdir -p "$CFG"
for src in "$REPO"/config/*; do
  name="$(basename "$src")"; dst="$CFG/$name"
  if [ -e "$dst" ] || [ -L "$dst" ]; then mkdir -p "$BACKUP"; mv "$dst" "$BACKUP/"; fi
  cp -a "$src" "$dst"
done
# Replace the placeholder with this user's home
grep -rIl --null "__HOME__" "$CFG/waybar" "$CFG/hypr" 2>/dev/null | xargs -0 -r sed -i "s#__HOME__#$HOME#g"
chmod +x "$CFG"/hypr/scripts/* "$CFG"/hypr/UserScripts/* "$CFG"/hypr/*.sh 2>/dev/null || true

echo "==> Wallpapers"
mkdir -p "$HOME/Pictures/wallpapers"
cp -an "$REPO"/wallpapers/. "$HOME/Pictures/wallpapers/"

echo "==> Services"
sudo systemctl enable --now NetworkManager bluetooth 2>/dev/null || true
systemctl --user enable --now pipewire pipewire-pulse wireplumber 2>/dev/null || true
xdg-user-dirs-update || true

cat <<MSG

Done. Next steps:
  1. Log out, and at the login screen (gear icon) choose "Hyprland". GNOME stays installed.
  2. NVIDIA GPU? Install nvidia-open + nvidia-utils and see config/hypr/UserConfigs/ENVariables.conf.
  3. Keyboard layouts live in ~/.config/hypr/UserConfigs/UserSettings.conf (kb_layout).
  4. Monitors: run nwg-displays, or edit ~/.config/hypr/monitors.conf.
Backups of anything replaced: $BACKUP
MSG
