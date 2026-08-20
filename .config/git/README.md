# Dotfiles

My minimal, modular, and XDG-compliant shell, editor, and automation configuration, managed via a bare Git repository.

## Overview

- **Storage Method**: Bare Git repository (no symlink managers like Stow or overhead like chezmoi)
- **Primary Shell**: Zsh (modularly structured under `~/.config/zsh/`)
- **Editors**: Vim & IdeaVim (`.vimrc` & `.ideavimrc`)
- **XDG Base Directory Specification**: Followed where applicable (`~/.config/`, `~/.local/`)

---

## Direct Start: Initial Setup (Existing Machine)

If you have already configured your files locally and want to initialize the bare repository:

```bash
# 1. Initialize the bare repository
git init --bare $HOME/.dotfiles

# 2. Define the tracking alias for the current session
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Prevent untracked HOME files from clogging 'dotfiles status'
dotfiles config --local status.showUntrackedFiles no

# 4. Add files to version control
dotfiles add ~/.zshenv ~/.zprofile ~/.zshrc ~/.vimrc ~/.ideavimrc ~/.gitconfig
dotfiles add ~/.config/zsh/
dotfiles add ~/.local/bin/

# 5. Commit and push to your remote repository
dotfiles commit -m "feat: initialize dotfiles bare repository"
dotfiles remote add origin git@github.com:<your-username>/dotfiles.git
dotfiles branch -M main
dotfiles push -u origin main    
```

## Daily Workflow

Use the dotfiles command in place of standard git for all configuration tracking.

```bash
# Check configuration status
dotfiles status

# Add modified configuration files
dotfiles add ~/.vimrc
dotfiles add ~/.config/zsh/aliases.zsh

# Commit and push updates
dotfiles commit -m "style: update vim bindings and zsh aliases"
dotfiles push
```
## Restoring on a New Machine

Execute the following steps to deploy your environment onto a clean operating system:

1. Clone the Repository & Deploy Configs

```bash
# Clone the repository as a separate Git directory
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:<your-username>/dotfiles.git ~$HOME/dotfiles-tmp

# Sync configuration files into the HOME directory
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/

# Clean up temporary directory
rm -rf dotfiles-tmp

# Hide untracked files in $HOME
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
```

2. Run Installation Scripts

```bash
# Make installation scripts executable
chmod +x $HOME/.local/bin/*.sh

# Run the primary bootstrapping script
$HOME/.local/bin/install.sh

# Source Zsh configuration to apply changes
source $HOME/.zshrc
```

## Directory Layout]

```text
~ (HOME)
├── .zshenv                         # Global environment variables (PATH, EDITOR, LANG)
├── .zprofile                       # Login shell configurations
├── .zshrc                          # Interactive shell entry point
├── .vimrc                          # Vim editor configurations
├── .ideavimrc                      # JetBrains IdeaVim configurations
├── .gitconfig                      # Global Git settings
│
├── .config/
│   ├── git/
│   │   └── ignore                  # Global gitignore file
│   └── zsh/
│       ├── aliases.zsh             # Command aliases (includes 'dotfiles' alias)
│       ├── history.zsh             # Zsh history options
│       ├── plugins.zsh             # Plugin loader
│       └── theme.zsh               # Prompt UI & theme configurations
│
└── .local/
    └── bin/                        # Executable automation scripts
        ├── Brewfile                # Homebrew bundle dump (macOS)
        ├── install.sh              # Main bootstrap entrypoint
        ├── setup-mac.sh            # macOS-specific setup
        ├── setup-debian.sh         # Linux/Debian-specific setup
        ├── common-packages-install.sh
        ├── vim-plugins-install.sh  # Native Vim plugins installation script
        └── vim-plugins-update.sh   # Native Vim plugins update script
```

