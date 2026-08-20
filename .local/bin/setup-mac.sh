#!/usr/bin/env bash

echo "📦 检测到 macOS，检查 Homebrew..."

command -v brew &>/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle install --file="$HOME/.local/bin/Brewfile"

"$HOME/.local/bin/common-packages-install.sh"

"$HOME/.local/bin/vim-plugins-install.sh"
