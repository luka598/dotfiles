#!/bin/bash
source utils/info.sh
source utils/init.sh

insertedStr='source $HOME/.dotfiles/enviroment'

if [[ -e $HOME/.dotfiles ]]; then
	rm $HOME/.dotfiles
	if [[ -e $HOME/.bashrc ]]; then
		# This does not remove newline that is inserted
		sed -i "s|$insertedStr||g" $HOME/.bashrc
	fi
	if [[ -e $HOME/.zshrc ]]; then
		# This does not remove newline that is inserted
		sed -i "s|$insertedStr||g" $HOME/.zshrc
	fi
fi
