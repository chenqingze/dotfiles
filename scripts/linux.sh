#!/bin/bash

set -eufo pipefail

echo "🐧 Starting Linux bootstrap..."

# 1. 安装 chezmoi（示例用 apt，按需改成你的发行版包管理器）
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "⚙️ Installing chezmoi..."

  # 假设是 Debian/Ubuntu 系统：
  if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y chezmoi
  else
    echo "⚠️ 请手动安装 chezmoi"
    exit 1
  fi
else
  echo "✅ chezmoi already installed"
fi

# 2. 初始化 chezmoi，指向仓库根目录的 home 目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)"
echo "📂 Initializing chezmoi with sourceDir: $SCRIPT_DIR/home"

chezmoi init --apply --source="$SCRIPT_DIR/home"

echo "🎉 Linux bootstrap completed!"

