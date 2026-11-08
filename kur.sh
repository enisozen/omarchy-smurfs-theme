#!/bin/bash
# Şirinler (The Smurfs) Omarchy Teması - Otomatik Kurulum Betiği
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_DEST="$HOME/.config/omarchy/themes/sirinler"
HOOK_DEST="$HOME/.config/omarchy/hooks/theme-set.d/20-theme-screensaver"
BRANDING_DIR="$HOME/.config/omarchy/branding"

echo -e "\033[1;36m==> Şirinler (The Smurfs) Omarchy Teması kuruluyor...\033[0m"

mkdir -p "$THEME_DEST" "$HOME/.config/omarchy/hooks/theme-set.d" "$BRANDING_DIR"

# Tema dosyalarını kopyala (.git hariç, böylece hyprland.lua ve özel yapılandırmalar tam yetkiyle çalışır)
rsync -a --exclude='.git' --exclude='kur.sh' --exclude='install.sh' --exclude='hooks' "$SCRIPT_DIR/" "$THEME_DEST/"

# Tema geçişlerinde Hakkında (about.txt) ve Ekran Koruyucu (screensaver.txt) senkronizasyon kancasını kur
install -Dm755 "$SCRIPT_DIR/hooks/20-theme-screensaver" "$HOOK_DEST"

# Şirinler Hakkında logosunu ve Ekran Koruyucusunu etkinleştir
cp -f "$THEME_DEST/about.txt" "$BRANDING_DIR/about.txt"
cp -f "$THEME_DEST/screensaver.txt" "$BRANDING_DIR/screensaver.txt"
rm -f "$HOME/.local/state/omarchy/windows/about.fit" 2>/dev/null || true

# Temayı uygula
if command -v omarchy >/dev/null 2>&1; then
  omarchy theme set sirinler || true
fi

echo -e "\033[1;32m✔ Şirinler teması, Hakkında logosu, Kilidi Aç ekranı ve Ekran Koruyucu başarıyla kuruldu!\033[0m"
