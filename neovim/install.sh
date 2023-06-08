#!/bin/bash
source $DOTFILES/utils/info.sh
source $DOTFILES/utils/init.sh

mkdir -p $HOME/.config/nvim
ln -s $PWD/init.lua $HOME/.config/nvim/init.lua
ln -s $PWD/lua $HOME/.config/nvim/lua
NVIM_INSTALL=1 nvim
