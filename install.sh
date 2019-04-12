#!/bin/bash
# *** NEED TO RUN THIS SCRIPT IN THE DIRECTORY THAT HOLDS THE SCRIPT ***
# Should previously run:
#    sudo apt update
#    sudo apt install zsh git vim tmux wget -y

# Copy configuration files
cp -rf --backup --suffix=.bak ./ ~/
cd ~/
rm install.sh README.md
rm -rf .git

# ZSH environment setup
if [[ -d ~/.oh-my-zsh ]]; then
    mv ~/.oh-my-zsh ~/.oh-my-zsh.bak
fi
rm -rf .oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ -d ~/.oh-my-zsh.bak ]]; then
    cp -rf ~/.oh-my-zsh.bak/custom ~/.oh-my-zsh/
fi

# fzf installation
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# VIM environment setup
rm -rf .vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Require password, therefore put it in the end
chsh -s /bin/zsh

