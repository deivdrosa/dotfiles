#!/usr/bin/env bash

set -e

echo "🔁 Restoring system from dotfiles..."

DOTFILES="$HOME/dotfiles"

# --- garante estrutura base ---
mkdir -p "$HOME/.local/bin"

# --- remove possível estado quebrado ---
rm -rf "$HOME/.local/bin/*" 2>/dev/null || true

# --- restaura scripts ---
cp -r "$DOTFILES/scripts/bin/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*

# --- garante PATH ---
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# --- configs essenciais ---
cp "$DOTFILES/.zshrc" "$HOME/" 2>/dev/null || true
cp "$DOTFILES/starship.toml" "$HOME/" 2>/dev/null || true

echo "🧠 restoring configs..."
mkdir -p "$HOME/.config/hypr"
cp -r "$DOTFILES/hypr/"* "$HOME/.config/hypr/" 2>/dev/null || true

mkdir -p "$HOME/.config/waybar"
cp -r "$DOTFILES/waybar/"* "$HOME/.config/waybar/" 2>/dev/null || true

echo "✅ Restore complete!"
echo "👉 restart Hyprland or logout/login"
