#!/bin/zsh
# -----------------------------------------------------------------------------
# 基础 Zsh 配置
# 设置路径、历史记录、颜色等基本环境变量
# -----------------------------------------------------------------------------

# PATH 配置 
# 确保用户bin目录存在且可执行
if [ -d "$HOME/bin" ] && [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    export PATH="$HOME/bin:$PATH"
fi

# 确保本地系统管理bin目录存在且可执行
if [ -d "/usr/local/sbin" ] && [[ ":$PATH:" != *":/usr/local/sbin:"* ]]; then
    export PATH="/usr/local/sbin:$PATH"
fi

# 确保本地用户bin目录存在且可执行 (与 /usr/local/bin 类似，但通常用于非root安装)
if [ -d "/usr/local/bin" ] && [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    export PATH="/usr/local/bin:$PATH"
fi

# 确保 ~/sbin 目录存在且可执行（有时用于用户私有的系统管理脚本）
if [ -d "$HOME/sbin" ] && [[ ":$PATH:" != *":$HOME/sbin:"* ]]; then
    export PATH="$HOME/sbin:$PATH"
fi

# 设置历史记录
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory  # History filepath
HISTSIZE=4096         # Maximum events for internal history
SAVEHIST=4096         # Maximum events in history file

export ERL_AFLAGS="-kernel shell_history enabled"

# 设置 fpath (Zsh 查找补全定义和函数的地方)
# 确保你的自定义补全目录在列表中
fpath=(
  ~/.zsh/functions                  		# 你的自定义函数
  /usr/local/share/zsh/site-functions 		# Homebrew 等第三方包的函数
  $(brew --prefix)/share/zsh-completions 	# 如果使用 Homebrew，额外的补全
  #/usr/share/zsh/site-functions       		# Linux 系统的默认 Zsh 共享函数
  $fpath
)

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# 启用颜色
autoload -U colors && colors
# enable colored output from ls, etc. 
#export CLICOLOR=true
#export LSCOLORS=GxFxCxDxBxegedabagaced
#export LSCOLORS="Gxfxcxdxbxegedabagacad"

#echo "✅ base config completed!"
