source "$(brew --prefix)/share/autojump/autojump.zsh"
source <(fzf --zsh)
source "$(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# plugins configurations

#zsh-autocomplete key mapping
bindkey              '^I'         menu-complete
bindkey "$terminfo[kcbt]" reverse-menu-complete
#zstyle '*:compinit' arguments -D -i -u -C -w
##Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
