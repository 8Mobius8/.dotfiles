#!/bin/sh

printf "\nAdding dev packages\n\n"

export DEBIAN_FRONTEND=noninteractive

apt-get update && \
apt-get install -y \
	vim \
	curl \
	git \
	npm \
	wget \
	w3m \
	&& apt-get clean

printf "\nSetting up nb\n\n"
npm install -g nb.sh

printf "\nSetting up bin and dotfiles\n\n"
ln -s ./.vimrc ~/.vimrc
ln -s ./.vim ~/.vim
ln -s ./bin ~/bin
ln -s ./.gitignore_global ~/.gitignore_global
ln -s ./.zshrc ~/.zshrc

printf "\nSetup oh my zsh\n\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended