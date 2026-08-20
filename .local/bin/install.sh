#!/usr/bin/env bash
set -e

echo "🚀 开始初始化开发环境..."

# 赋予本地 bin 权限
chmod +x $HOME/.local/bin/* 2>/dev/null || true

# 基础包管理器检测与工具安装
if [[ "$OSTYPE" == "darwin"* ]]; then
    "$HOME/.local/bin/setup-mac.sh"
elif command -v apt-get &>/dev/null; then
    "$HOME/.local/bin/setup-debian.sh"
fi


echo "✨ 环境初始化完毕！请执行 'source ~/.zshrc' 激活配置。"
