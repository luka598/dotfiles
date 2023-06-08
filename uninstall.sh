#!/bin/bash
source utils/info.sh
source utils/init.sh

export_dotfiles='export DOTFILES=$HOME/.dotfiles'

if [[ -e $HOME/.dotfiles ]]; then
	rm $HOME/.dotfiles
	if [[ -e $HOME/.bashrc ]]; then
		# This does not remove newline that is inserted
		sed -i "s|$export_dotfiles||g" $HOME/.bashrc
	fi
fi
