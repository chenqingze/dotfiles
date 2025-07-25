#!/bin/zsh
set -eufo pipefail

# 对vimrc 创建软链

TARGET="$HOME/.vim/vimrc"

LINK_NAME="$HOME/.vimrc"

if [ ! -L "$LINK_NAME" ]; then
    # If the link doesn't exist, first check if the target file exists.
    if [ -f "$TARGET" ]; then
        # Create the symbolic link
        # -s: create a symbolic link
        # -f: force, useful if a regular file or broken link exists at LINK_NAME
        ln -sf "$TARGET" "$LINK_NAME"
        echo "Symbolic link '$LINK_NAME' -> '$TARGET' created successfully."
    else
        echo "Error: Target file '$TARGET' does not exist. Cannot create the link."
        echo "Please ensure '$TARGET' exists before running this script."
    fi
else
    echo "Symbolic link '$LINK_NAME' already exists. No action taken."
fi

echo "✅ post.sh completed successfully."

