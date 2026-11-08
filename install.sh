#!/bin/bash
# The Smurfs Theme for Omarchy Linux - Automated Installer
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DEST="$HOME/.config/omarchy/themes/smurfs"
THEME_TR_DEST="$HOME/.config/omarchy/themes/sirinler"
HOOK_DEST="$HOME/.config/omarchy/hooks/theme-set.d/20-theme-screensaver"
BRANDING_DIR="$HOME/.config/omarchy/branding"

echo -e "\033[1;36m==> Installing The Smurfs Theme for Omarchy Linux...\033[0m"

mkdir -p "$THEME_DEST" "$THEME_TR_DEST" "$HOME/.config/omarchy/hooks/theme-set.d" "$BRANDING_DIR"

# Copy theme files (excluding .git so hyprland.lua and custom configs run with full local privileges)
rsync -a --exclude='.git' --exclude='kur.sh' --exclude='install.sh' --exclude='hooks' "$SCRIPT_DIR/" "$THEME_DEST/"
rsync -a --exclude='.git' --exclude='kur.sh' --exclude='install.sh' --exclude='hooks' "$SCRIPT_DIR/" "$THEME_TR_DEST/"

# Install theme-set hook for automatic About logo and Screensaver syncing
install -Dm755 "$SCRIPT_DIR/hooks/20-theme-screensaver" "$HOOK_DEST"

# Activate The Smurfs About logo and Screensaver
cp -f "$THEME_DEST/about.txt" "$BRANDING_DIR/about.txt"
cp -f "$THEME_DEST/screensaver.txt" "$BRANDING_DIR/screensaver.txt"
rm -f "$HOME/.local/state/omarchy/windows/about.fit" 2>/dev/null || true

# Apply theme
if command -v omarchy >/dev/null 2>&1; then
  omarchy theme set smurfs || true
fi

echo -e "\033[1;32m✔ The Smurfs theme, About logo, Unlock screen, and Screensaver have been installed!\033[0m"
