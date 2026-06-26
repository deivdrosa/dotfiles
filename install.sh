#!/usr/bin/env bash

set -e

echo "🚀 Installing dotfiles..."

DOTFILES="$HOME/dotfiles"

# --- scripts ---
echo "📦 Setting up local bin..."
mkdir -p "$HOME/.local/bin"
cp -r "$DOTFILES/scripts/bin/"* "$HOME/.local/bin/"
chmod +x "$HOME/.local/bin/"*

# --- zsh ---
echo "🐚 Setting shell configs..."
cp "$DOTFILES/.zshrc" "$HOME/" 2>/dev/null || true
cp "$DOTFILES/zshrc" "$HOME/.zshrc" 2>/dev/null || true

# --- starship ---
cp "$DOTFILES/starship.toml" "$HOME/" 2>/dev/null || true

# --- hypr ---
echo "🪟 Hyprland config..."
mkdir -p "$HOME/.config/hypr"
cp -r "$DOTFILES/hypr/"* "$HOME/.config/hypr/"

# --- waybar ---
echo "📊 Waybar..."
mkdir -p "$HOME/.config/waybar"
cp -r "$DOTFILES/waybar/"* "$HOME/.config/waybar/"

# --- mako ---
echo "🔔 Mako..."
mkdir -p "$HOME/.config/mako"
cp "$DOTFILES/mako/config" "$HOME/.config/mako/" 2>/dev/null || true

echo "✅ Install complete!"
echo "👉 restart shell or run: source ~/.zshrc"
