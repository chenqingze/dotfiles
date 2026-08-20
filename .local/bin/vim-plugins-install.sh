#!/usr/bin/env zsh
set -euo pipefail

# =============================================================================
# Vim 9.1+ third-party install (macOS)
# packpath: ~/.vim/pack/plugins/{start,opt}
# =============================================================================

START="$HOME/.vim/pack/plugins/start"
OPT="$HOME/.vim/pack/plugins/opt"
mkdir -p "$START" "$OPT"

clone_or_update() {
  local url="$1"
  local dest="$2"
  if [[ -d "$dest/.git" ]]; then
    echo "Updating $(basename "$dest") ..."
    git -C "$dest" pull --ff-only
  else
    echo "Cloning $(basename "$dest") ..."
    git clone --depth=1 "$url" "$dest"
  fi
}

# ----- start/ : 启动即加载 -----
clone_or_update https://github.com/tpope/vim-surround          "$START/vim-surround"
clone_or_update https://github.com/tpope/vim-repeat            "$START/vim-repeat"
clone_or_update https://github.com/justinmk/vim-sneak          "$START/vim-sneak"
clone_or_update https://github.com/mg979/vim-visual-multi      "$START/vim-visual-multi"
clone_or_update https://github.com/junegunn/fzf.vim            "$START/fzf.vim"
clone_or_update https://github.com/chenqingze/smartim.git      "$START/smartim"

# ----- opt/ : vimrc 里 packadd -----
clone_or_update https://github.com/yegappan/lsp                "$OPT/lsp"

# ----- helptags -----
vim -u NONE -c "helptags ALL" -c q

echo
echo "Done. Installed under:"
echo "  $START"
echo "  $OPT"
ls -1 "$START"
ls -1 "$OPT"
echo
echo "Check:"
echo "  vim -c 'echo glob(\"~/.vim/pack/plugins/start/*\")' -c q"
