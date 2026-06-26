#!/usr/bin/env bash
set -e

echo "🚀 [BOOTSTRAP] iniciando setup do sistema..."

# =========================
# 1. CHECAGEM BÁSICA
# =========================

echo "🔎 verificando dependências básicas..."

if ! command -v git >/dev/null 2>&1; then
  echo "❌ git não encontrado. Instalando..."
  sudo pacman -S --noconfirm git
fi

# =========================
# 2. REPO
# =========================

if [ ! -d "$HOME/dotfiles" ]; then
  echo "📦 clonando dotfiles..."
  git clone https://github.com/deivdrosa/dotfiles.git "$HOME/dotfiles"
fi

cd "$HOME/dotfiles"

# =========================
# 3. PACOTES DO SISTEMA
# =========================

echo "📦 salvando snapshot de pacotes..."

pacman -Qqe > pacman.txt

if command -v yay >/dev/null 2>&1; then
  yay -Qqe > aur.txt
else
  echo "⚠️ yay não instalado (ignorando AUR snapshot)"
fi

# =========================
# 4. INSTALAÇÃO BASE (opcional segurança)
# =========================

echo "⚙️ garantindo base de build tools..."

sudo pacman -S --needed --noconfirm base-devel

# =========================
# 5. RODAR INSTALL
# =========================

echo "⚙️ rodando install + restore..."

./install.sh
./restore.sh

# =========================
# 6. FINAL
# =========================

echo "✅ bootstrap concluído com sucesso!"
echo "🔁 recomenda-se reiniciar sessão"
