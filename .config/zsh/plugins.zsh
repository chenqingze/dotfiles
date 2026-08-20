# ~/.config/zsh/plugins.zsh

# ------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------

if command -v brew >/dev/null 2>&1; then
    BREW_PREFIX="$(brew --prefix)"
fi


# ------------------------------------------------------------
# Completion definitions
# ------------------------------------------------------------

if [[ -d "$BREW_PREFIX/share/zsh-completions" ]]; then
    fpath=(
        "$BREW_PREFIX/share/zsh-completions"
        $fpath
    )
fi

autoload -Uz compinit
compinit


# ------------------------------------------------------------
# autojump
# ------------------------------------------------------------

if [[ -f "$BREW_PREFIX/share/autojump/autojump.zsh" ]]; then
    source "$BREW_PREFIX/share/autojump/autojump.zsh"
fi


# ------------------------------------------------------------
# fzf
# ------------------------------------------------------------

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi


# ------------------------------------------------------------
# zsh-autosuggestions
# ------------------------------------------------------------

if [[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi


# ------------------------------------------------------------
# SSH host completion
# ------------------------------------------------------------

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
    'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# ------------------------------------------------------------
# zsh-syntax-highlighting
# ------------------------------------------------------------

if [[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi 

