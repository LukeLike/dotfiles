#!/bin/bash
cd ~
tar czvf ~/dotfiles.tgz .oh-my-zsh .pip .vim .condarc .zshrc .gitconfig .npmrc \
    .tmux.conf .tmux.conf.local .vimrc .config/coc .config/nvim
