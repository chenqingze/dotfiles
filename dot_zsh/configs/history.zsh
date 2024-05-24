setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory  # History filepath
HISTSIZE=4096         # Maximum events for internal history
SAVEHIST=4096         # Maximum events in history file

export ERL_AFLAGS="-kernel shell_history enabled"
