1. Manually install git, zsh, tmux etc.
```bash
sudo apt update
sudo apt install zsh git vim tmux wget -y
```
2. Run bash file install.sh to copy the files into the right places and install relevant packages (**PLEASE RUN THE SCRIPT IN THE DIRECTORY THAT HOLDS IT**).
3. List of configurations:
    - .vimrc
    - .bashrc
    - .zshrc
    - .npmrc
    - .gitconfig
    - .pip/pip.conf
    - .vim/colors/Tomorrow-Night.vim
    - .vim/after/ftplugin/\*.vim (setting for different filetypes)
    - .condarc
    - .tmux.conf (general settings, mostly taken from [gpakosz/.tmux](https://github.com/gpakosz/.tmux.git))
    - .tmux.conf.local (local settings)
4. List of packages to install:
    - [oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
    - [zsh autosuggestion](https://github.com/zsh-users/zsh-autosuggestions)
    - [vim-plug](https://github.com/junegunn/vim-plug)

