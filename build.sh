#!/bin/env bash

set -e

bin_scripts="/usr/local/bin/"
configs_dir="./config_files/"

for arg in "$@"; do
	if [ "$arg" == "-c" ] || [ "$arg" == "--clean" ] || [ "$arg" == "--clear" ]; then
		sudo rm -rf $configs_dir ./bin
		break
	fi
done


mkdir -p $configs_dir 

sudo cp -r $bin_scripts . 
cp -r $HOME/.config/foot/foot.ini $configs_dir
cp -r $HOME/.config/sway/config $configs_dir
cp -r $HOME/.config/waybar/ $configs_dir
cp -r $HOME/.zshrc $configs_dir/zshrc
cp -r $HOME/.config/nvim/init.lua $configs_dir
cp -r $HOME/.vimrc $configs_dir/vimrc
cp -r $HOME/.config/qutebrowser/autoconfig.yml $configs_dir
