#!/bin/sh

printf "\nAdding dev packages\n\n"

export DEBIAN_FRONTEND=noninteractive

printf "\nSetting up bin and dotfiles\n\n"
ln -s ./.vimrc ~/.vimrc
ln -s ./.vim ~/.vim
ln -s ./.gitignore_global ~/.gitignore_global
ln -s ./.zshrc ~/.zshrc

printf "\nSetup oh my zsh\n\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
