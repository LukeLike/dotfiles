#!/bin/bash
# *** NEED TO RUN THIS SCRIPT IN THE DIRECTORY THAT HOLDS THE SCRIPT ***
# Should previously run:
#    sudo apt update
#    sudo apt install zsh git vim tmux wget curl -y

# Copy configuration files
cp -rf --backup --suffix=.bak ./ ~/
cd ~/
rm install.sh README.md archive.sh
rm -rf .git

# Do not override git settings
if [ -e ~/.gitconfig.bak ]; then
    mv ~/.gitconfig.bak ~/.gitconfig
fi

# ZSH environment setup
if [[ -d ~/.oh-my-zsh ]]; then
    cp -rf  ~/.oh-my-zsh/* ~/.oh-my-zsh.bak
fi
rm -rf .oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ -d ~/.oh-my-zsh.bak ]]; then
    cp -rf ~/.oh-my-zsh.bak/custom ~/.oh-my-zsh/
fi

# VIM environment setup
rm -rf .vim/plugged
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Require password, therefore put it in the end
chsh -s /bin/zsh

