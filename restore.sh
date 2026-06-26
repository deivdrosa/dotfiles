#!/usr/bin/env bash
set -e

REPO="$HOME/dotfiles"

echo "🔁 [RESTORE] iniciando reconstrução completa do sistema..."

cd "$REPO"

# =========================
# 1. PACMAN BASE
# =========================

if [ -f pacman.txt ]; then
  echo "📦 restaurando pacotes pacman..."
  sudo pacman -S --needed --noconfirm - < pacman.txt
else
  echo "⚠️ pacman.txt não encontrado"
fi

# =========================
# 2. AUR PACKAGES
# =========================

if command -v yay >/dev/null 2>&1; then
  if [ -f aur.txt ]; then
    echo "📦 restaurando AUR..."
    yay -S --needed --noconfirm - < aur.txt
  else
    echo "⚠️ aur.txt não encontrado"
  fi
else
  echo "⚠️ yay não instalado (pulando AUR)"
fi

# =========================
# 3. SYSTEMD SERVICES
# =========================

echo "⚙️ ativando serviços essenciais..."

SERVICES=(
  "NetworkManager"
  "bluetooth"
  "sddm"
  "docker"
  "ollama"
)

for svc in "${SERVICES[@]}"; do
  if systemctl list-unit-files | grep -q "$svc.service"; then
    echo "🔧 enabling $svc"
    sudo systemctl enable --now "$svc"
  else
    echo "⚠️ serviço não encontrado: $svc"
  fi
done

# =========================
# 4. DOTFILES
# =========================

echo "🎨 aplicando dotfiles..."

rsync -a "$REPO/.config/" "$HOME/.config/"
rsync -a "$REPO/scripts/" "$HOME/.local/bin/" 2>/dev/null || true

cp "$REPO/.zshrc" "$HOME/" 2>/dev/null || true
cp "$REPO/.bashrc" "$HOME/" 2>/dev/null || true

# =========================
# 5. FINAL
# =========================

echo "✅ RESTORE COMPLETO FINALIZADO"
echo "🔁 reinicie a sessão para aplicar tudo"
