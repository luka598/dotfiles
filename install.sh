#!/bin/bash
source utils/info.sh
source utils/init.sh
if [[ -e $HOME/.dotfiles ]]; then
	echo "$HOME/.dotfiles already exsists!"
else
	ln -s $PWD $HOME/.dotfiles
	if [[ -e $HOME/.bashrc ]]; then
		echo 'source $HOME/.dotfiles/enviroment' >> $HOME/.bashrc
	fi
	if [[ -e $HOME/.zshrc ]]; then
		echo 'source $HOME/.dotfiles/enviroment' >> $HOME/.zshrc
	fi
fi
