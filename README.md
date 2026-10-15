# Hyprland dotfiles

Hyprland + Waybar + Rofi + Kitty + SwayNC rice for Arch Linux (JaKooLit-based, wallust/pywal theming).

## Install
```
git clone <repo-url> ~/dotfiles && cd ~/dotfiles && ./install.sh
```
Then log out and pick **Hyprland** at the login screen (GNOME stays installed).

Existing configs are moved to `~/.config-backup-<timestamp>` before anything is replaced.

## Layout
- `config/` – copied into `~/.config`
- `packages/pacman.txt`, `packages/aur.txt` – installed by `install.sh`
- `wallpapers/` – copied to `~/Pictures/wallpapers`

## Per-machine tweaks
- GPU (NVIDIA): `~/.config/hypr/UserConfigs/ENVariables.conf`
- Monitors: `nwg-displays` or `~/.config/hypr/monitors.conf`
- Keyboard layouts: `kb_layout` in `~/.config/hypr/UserConfigs/UserSettings.conf`
