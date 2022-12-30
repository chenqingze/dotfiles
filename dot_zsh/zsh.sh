fpath=(~/.zsh/functions $fpath)
autoload load-tools load-configs
# load custom executable tools
load-tools "$HOME/.zsh/tools"
# load configs
load-configs "$HOME/.zsh/configs"

