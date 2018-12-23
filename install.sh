#!/bin/bash
# *** NEED TO RUN THIS SCRIPT IN THE DIRECTORY THAT HOLDS THE SCRIPT ***
# Should previously run:
#    sudo apt update
#    sudo apt install zsh git vim tmux wget -y

# Copy configuration files
cp -rf ./ ~/
cd ~/
rm install.sh README.md
rm -rf .git

# ZSH environment setup
rm -rf .oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# VIM environment setup
rm -rf .vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Require password, therefore put it in the end
chsh -s /bin/zsh

