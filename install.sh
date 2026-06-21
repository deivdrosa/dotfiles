#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================"
echo "Instalando pacotes pacman"
echo "============================"

sudo pacman -S --needed $(cat "$DIR/pkglist/pacman.txt")
sudo pacman -S --needed swww
echo "============================"
echo "Verificando yay"
echo "============================"

if ! command -v yay &> /dev/null; then
    echo "yay não encontrado, instalando..."

    sudo pacman -S --needed git base-devel

    cd ~
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

echo "============================"
echo "Instalando AUR"
echo "============================"

sudo pacman -S --needed awww
mkdir -p ~/Pictures/wallpapers
cp -r "$DIR/wallpapers" ~/Pictures/
mkdir -p ~/Pictures/wallpapers
cp "$DIR/awww/wallpaper.sh" ~/Pictures/wallpapers/
chmod +x ~/Pictures/wallpapers/wallpaper.sh
yay -S --needed $(cat "$DIR/pkglist/aur.txt")

echo "============================"
echo "Copiando configs"
echo "============================"

mkdir -p ~/.local/bin
cp "$DIR/scripts/"* ~/.local/bin/
chmod +x ~/.local/bin/*

cp "$DIR/zshrc" ~/.zshrc

mkdir -p ~/.config
cp -r "$DIR/fastfetch" ~/.config/
cp -r "$DIR/kitty" ~/.config/

echo "============================"
echo "Concluído com sucesso"
echo "============================"
