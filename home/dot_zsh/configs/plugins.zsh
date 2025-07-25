#!/bin/zsh
# -----------------------------------------------------------------------------
# 插件加载配置
# 按照依赖关系加载 Zsh 插件
# -----------------------------------------------------------------------------

# --- Zsh 插件加载函数 ---
load_plugins() {

  local plugin_files=("$@")
  if (( ${#plugin_files[@]} == 0 )); then
    echo "⚠️  未传入任何插件路径，请传入插件文件路径数组。" >&2
    return 1
  fi

  for plugin_file in "${plugin_files[@]}"; do
    if [ -f "$plugin_file" ]; then
      source "$plugin_file"
      #echo "✅ $plugin_file load completed!"
    else
      echo "❌ Zsh 插件文件未找到: $plugin_file。已跳过。" >&2
      return 1
    fi
  done
}

# 声明插件位置
declare -a ZSH_PLUGINS=(
	"/usr/local/share/autojump/autojump.zsh"
	"$HOME/.zsh/plugins/fzf.zsh"
	"$(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
	"$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
	"$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

# 加载插件
load_plugins "${ZSH_PLUGINS[@]}" 

#echo "✅ plugins config completed!"
