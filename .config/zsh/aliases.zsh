# ~/.config/zsh/aliases.zsh

# -----------------------------------------------------------------------------
# 别名配置
# -----------------------------------------------------------------------------

# Advanced Aliases.
# Use with caution
#

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# ls, the common ones I use a lot shortened for rapid fire usage
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias ldot='ls -ld .*'

alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' # Quick access to the .zshrc file

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

