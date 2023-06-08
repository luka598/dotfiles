#!/bin/bash
source utils/info.sh
source utils/init.sh
if [[ -e $HOME/.dotfiles ]]; then
	echo "$HOME/.dotfiles already exsists!"
else
	if [[ -e $HOME/.bashrc ]]; then
		echo 'export DOTFILES=$HOME/.dotfiles' >> $HOME/.bashrc
	fi
	ln -s $PWD $HOME/.dotfiles
fi
