#!/bin/env bash

# set -e

bin_scripts="/usr/local/bin/"
scripts_dir="./config_files/"

for arg in "$@"; do
	if [ "$arg" == "-c" ] || [ "$arg" == "--clean" ] || [ "$arg" == "--clear" ]; then
		sudo rm -rf $scripts_dir ./bin
		break
	fi
done


mkdir -p $scripts_dir 

sudo cp -r $bin_scripts . 
cp -r $HOME/.config/foot/foot.ini $scripts_dir
cp -r $HOME/.config/sway/config $scripts_dir
cp -r $HOME/.config/waybar/ $scripts_dir
cp -r $HOME/.zshrc $scripts_dir/zshrc
cp -r $HOME/.config/nvim/init.lua $scripts_dir
cp -r $HOME/.vimrc $scripts_dir/vimrc
