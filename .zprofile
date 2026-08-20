## ~/.zprofile
#
# Loaded for login shells.
# macOS Terminal / iTerm2 normally starts a login shell. 

# ------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ------------------------------------------------------------
# PATH
# ------------------------------------------------------------

# Zsh's $path array and $PATH are synchronized automatically.
#
# typeset -U prevents duplicate entries.
typeset -U path PATH

# System administration binaries
[[ -d /usr/local/sbin ]] && path=("/usr/local/sbin" $path)

# Local binaries
[[ -d /usr/local/bin ]] && path=("/usr/local/bin" $path)

# User-level binaries
[[ -d "$HOME/sbin" ]] && path=("$HOME/sbin" $path)
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# Rust
if [[ -d "$(brew --prefix rustup)/bin" ]]; then
    path=("$(brew --prefix rustup)/bin" $path)
fi

# Node.js
if [[ -d "$(brew --prefix node@24)/bin" ]]; then
    path=("$(brew --prefix node@24)/bin" $path)
fi

# Java 21
if JAVA_HOME=$(/usr/libexec/java_home -v 21 2>/dev/null); then
    export JAVA_HOME
    path=("$JAVA_HOME/bin" $path)
fi

# LM Studio
export LM_STUDIO_API_BASE="http://localhost:1234/v1"

[[ -d "$HOME/.lmstudio/bin" ]] && path=("$HOME/.lmstudio/bin" $path)

# OrbStack
if [[ -f "$HOME/.orbstack/shell/init.zsh" ]]; then
    source "$HOME/.orbstack/shell/init.zsh"
fi


