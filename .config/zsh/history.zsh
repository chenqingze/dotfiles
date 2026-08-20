# ~/.config/zsh/history.zsh

HISTFILE="$HOME/.zhistory"

HISTSIZE=50000
SAVEHIST=50000

setopt hist_ignore_all_dups
setopt inc_append_history
setopt share_history
