#!/bin/zsh
set -eufo pipefail

echo "🖥  Starting macOS bootstrap..."

# 1. 安装 Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed"
fi

# 2. 确保 brew 路径生效（兼容 Intel/M1/M2）
if [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. 安装 chezmoi
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "📦 Installing chezmoi..."
  brew install chezmoi
else
  echo "✅ chezmoi already installed"
fi

# 4. 切换默认 shell 为 zsh（macOS 默认是 zsh，这步可选）
if [[ "$SHELL" != "/bin/zsh" ]]; then
  echo "🔁 Changing default shell to zsh..."
  chsh -s /bin/zsh || echo "⚠️ chsh failed, please change shell manually."
else
  echo "✅ Default shell is already zsh"
fi

# 5. 初始化 chezmoi，使用仓库根目录的 home 作为 sourceDir
SCRIPT_DIR="$(cd "$(dirname "${(%):-%N}")/../" && pwd)"

echo "📁 设置 chezmoi sourceDir: $SCRIPT_DIR"
# 创建 chezmoi 配置目录（如果不存在）
mkdir -p "$HOME/.config/chezmoi"

# 写入或更新 ~/.config/chezmoi/chezmoi.toml
cat > "$HOME/.config/chezmoi/chezmoi.toml" <<EOF
sourceDir = "$SCRIPT_DIR/home"
EOF

echo "✅ 写入 ~/.config/chezmoi/chezmoi.toml 完成"

echo "📂 Initializing chezmoi with sourceDir: $SCRIPT_DIR/home"

chezmoi init --apply --source="$SCRIPT_DIR/home" --verbose

"$SCRIPT_DIR/scripts/post.sh"

echo "🎉 macOS bootstrap completed, enjoy your time!"
