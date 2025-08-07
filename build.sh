#!/usr/bin/bash

set -e

bin_scripts="/usr/local/bin/"
configs_dir="./config_files/"
script_name="${0##*/}"

error() {
  echo -e "\e[1;31m$script_name: $1\e[0m" >&2
}

success() {
  echo -e "\e[1;32m$script_name: $1\e[0m"
}

rm -rf "$configs_dir" ./bin

mkdir -p "$configs_dir"

cp -r "$bin_scripts" .

declare -a files=(
  "$HOME/.config/foot/foot.ini|foot.ini"
  "$HOME/.config/sway/config|config"
  "$HOME/.config/waybar/|waybar"
  "$HOME/.zshrc|zshrc"
  "$HOME/.config/nvim/init.lua|init.lua"
  "$HOME/.vimrc|vimrc"
  "$HOME/.gitconfig|gitconfig"
)

for file in "${files[@]}"; do
  src="${file%%|*}"
  dst="${file#*|}"
  
  if [[ -d "$src" ]]; then
    if ! cp -r "$src" "$configs_dir/$dst"; then
      error "Failed to copy directory $src"
    fi
  else
    if ! cp "$src" "$configs_dir/$dst"; then
      error "Failed to copy file $src"
    fi
  fi
done
