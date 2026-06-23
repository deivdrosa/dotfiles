#!/bin/bash

set -e

echo "🚀 Iniciando setup do dotfiles..."

# ----------------------------
# PACOTES BASE (Arch)
# ----------------------------
echo "📦 Instalando pacotes..."

sudo pacman -S --needed \
hyprland waybar kitty rofi \
wl-clipboard cliphist \
xdg-desktop-portal-hyprland \
git base-devel

# ----------------------------
# DIRETÓRIOS USUÁRIO
# ----------------------------
echo "📁 Criando diretórios..."

mkdir -p ~/.config
mkdir -p ~/.local/bin

# ----------------------------
# HYPRLAND
# ----------------------------
echo "⚙️ Instalando Hyprland config..."

cp -r ./hypr ~/.config/ 2>/dev/null || true

# ----------------------------
# WAYBAR
# ----------------------------
echo "⚙️ Instalando Waybar..."

cp -r ./waybar ~/.config/ 2>/dev/null || true

# ----------------------------
# KITTy / ALACRITTY
# ----------------------------
echo "⚙️ Terminais..."

cp -r ./kitty ~/.config/ 2>/dev/null || true
cp -r ./alacritty ~/.config/ 2>/dev/null || true

# ----------------------------
# SCRIPTS
# ----------------------------
echo "🧠 Instalando scripts..."

cp -r ./scripts/* ~/.local/bin/ 2>/dev/null || true
chmod +x ~/.local/bin/* 2>/dev/null || true

# ----------------------------
# SHELL CONFIG
# ----------------------------
echo "🐚 Shell config..."

cp .bashrc ~ 2>/dev/null || true
cp .zshrc ~ 2>/dev/null || true

# ----------------------------
# CLIPBOARD FIX (teu caso Hyprland)
# ----------------------------
echo "📋 Clipboard setup..."

mkdir -p ~/.config/hypr

grep -qxF 'exec-once = wl-paste --type text --watch cliphist store' ~/.config/hypr/hyprland.conf || \
echo 'exec-once = wl-paste --type text --watch cliphist store' >> ~/.config/hypr/hyprland.conf

grep -qxF 'exec-once = wl-paste --type image --watch cliphist store' ~/.config/hypr/hyprland.conf || \
echo 'exec-once = wl-paste --type image --watch cliphist store' >> ~/.config/hypr/hyprland.conf

# ----------------------------
# FINAL
# ----------------------------
echo "✅ Setup finalizado!"
echo "🔁 Reinicia a sessão Hyprland para aplicar tudo"
