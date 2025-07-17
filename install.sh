#!/bin/bash

set -e

bin_dir="./bin/"
configs_dir="./config_files/"
bin_scripts="/usr/local/bin/"
script_name="${0##*/}"

error() {
  echo -e "\e[1;31m$script_name: $1\e[0m" >&2
}

success() {
  echo -e "\e[1;32m$script_name: $1\e[0m"
}

for arg in "$@"; do
  if [[ "$arg" == "-c" || "$arg" == "--clean" ]]; then
    declare -a files=(
      "$HOME/.config/foot/foot.ini"
      "$HOME/.config/sway/config"
      "$HOME/.config/waybar/"
      "$HOME/.zshrc"
      "$HOME/.config/nvim/init.lua"
      "$HOME/.vimrc"
      "$HOME/.gitconfig"
    )

    for file in "${files[@]}"; do
      if [[ -d "$file" && "$file" != */*.* ]]; then
        rm -rf "$file"
      else
        rm -f "$file"
      fi
    done

    if [[ -d "$bin_dir" ]]; then
      for f in "$bin_dir"*; do
        name="${f##*/}"
        rm -f "${bin_scripts}${name}"
      done
    fi

    success "$arg: Successful"
    exit 0
  fi
done

if [[ -d "$bin_dir" ]]; then
  for f in "$bin_dir"*; do
    if [[ -f "$f" && -x "$f" ]]; then
      cp "$f" "$bin_scripts"
    fi
  done
  success "Binaries installed to $bin_scripts"
fi

declare -a files=(
  "$configs_dir/foot.ini|$HOME/.config/foot/foot.ini"
  "$configs_dir/config|$HOME/.config/sway/config"
  "$configs_dir/waybar|$HOME/.config/waybar"
  "$configs_dir/zshrc|$HOME/.zshrc"
  "$configs_dir/init.lua|$HOME/.config/nvim/init.lua"
  "$configs_dir/vimrc|$HOME/.vimrc"
  "$configs_dir/gitconfig|$HOME/.gitconfig"
)

for file in "${files[@]}"; do
  src="${file%%|*}"
  dst="${file#*|}"

  if [[ -d "$src" ]]; then
    mkdir -p "$dst"
    if ! cp -r "$src"/* "$dst"/; then
      error "Failed to copy directory $src"
    fi
  else
    mkdir -p "$(dirname "$dst")"
    if ! cp "$src" "$dst"; then
      error "Failed to copy file $src"
    fi
  fi
done

success "All configs installed."
