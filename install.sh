#!/bin/bash
# *** NEED TO RUN THIS SCRIPT IN THE DIRECTORY THAT HOLDS THE SCRIPT ***
# Should previously run:
#    sudo apt update
#    sudo apt install zsh git vim tmux wget curl -y

dispatch_by_os() {
    _cmd_var=$1
    if [[ "$(uname)" == "Darwin" ]]; then
        if command -v "g${!_cmd_var}" >/dev/null 2>&1; then
            eval ${_cmd_var}\="g${!_cmd_var}"
        else
            echo "g${!_cmd_var} command not found, please install coreutils"
            exit 1
        fi
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
        if command -v ${!_cmd_var} >/dev/null 2>&1; then
            eval $_cmd_var\=${!_cmd_var}
        else
            echo "${!_cmd_var} command not found, please install coreutils"
            exit 1
        fi
    fi
}

cp_cmd="cp"
dispatch_by_os "cp_cmd"
rm_cmd="rm"
dispatch_by_os "rm_cmd"
mv_cmd="mv"
dispatch_by_os "mv_cmd"
mkdir_cmd="mkdir"
dispatch_by_os "mkdir_cmd"
ln_cmd="ln"
dispatch_by_os "ln_cmd"

# Copy configuration files
$cp_cmd -rf --backup=numbered ./ ~/
cd ~/
$rm_cmd install.sh README.md archive.sh
$rm_cmd -rf .git

# Do not override git settings
if [ -e ~/.gitconfig.\~1\~ ]; then
    $mv_cmd ~/.gitconfig.\~1\~ ~/.gitconfig
fi


# ZSH environment setup
if [[ -d ~/.oh-my-zsh ]]; then
    if [[ ! -d ~/.oh-my-zsh.\~1\~ ]]; then
        $mkdir_cmd ~/.oh-my-zsh.\~1\~
    fi
    $cp_cmd -rf  ~/.oh-my-zsh/* ~/.oh-my-zsh.\~1\~
fi
$rm_cmd -rf .oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ -d ~/.oh-my-zsh.\~1\~ ]]; then
    $cp_cmd -rf ~/.oh-my-zsh.\~1\~/custom ~/.oh-my-zsh/
fi

# VIM environment setup
$rm_cmd -rf .vim/plugged
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# NeoVim setup
if [[ ! -e ~/.config/nvim/coc-settings.json ]]; then
    $ln_cmd ~/.vim/coc-settings.json ~/.config/nvim/coc-settings.json
fi

# Require password, therefore put it in the end
chsh -s /bin/zsh

