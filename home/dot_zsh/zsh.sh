# manually load configs 
export CONFIG_DIR="$HOME/.zsh/configs"
source "$CONFIG_DIR/base.zsh"
source "$CONFIG_DIR/theme.zsh"
source "$CONFIG_DIR/plugins.zsh"
source "$CONFIG_DIR/aliases.zsh"

# load custom executable tools
autoload load-tools && load-tools "$HOME/.zsh/tools"
