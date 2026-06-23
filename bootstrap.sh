#!/usr/bin/env bash

set -e

echo "🚀 Bootstrapping dotfiles setup..."

if [ ! -d "$HOME/dotfiles" ]; then
  echo "📦 Cloning dotfiles..."
  git clone https://github.com/deivdrosa/dotfiles.git "$HOME/dotfiles"
fi

cd "$HOME/dotfiles"

echo "⚙️ Running installer..."
chmod +x install.sh
./install.sh

echo "✅ Done. Restart session recommended."
