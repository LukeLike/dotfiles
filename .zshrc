# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="luke-ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ubuntu docker zsh-autosuggestions cargo shrink-path)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias mysql='mysql --port=3306 --protocol=TCP'
alias dos2unix_folder='find -type f -print0|xargs -0 dos2unix'

# environment variables:
export TERM=xterm-256color

# export CXX='/usr/bin/clang++'

mkdir -p $HOME/bin
mkdir -p $HOME/.local/bin
export PATH=$HOME/bin:$HOME/.npm-global/bin:$HOME/.local/bin:$PATH
alias yd='ydcv -s'
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Docker
alias docker_init='export DOCKER_HOST=tcp://$(cd /mnt/c && docker-machine.exe ip):2376'
alias docker_clear='docker rm -v $(docker ps -aq -f status=exited)'

zstyle ':completion::complete:*' use-cache 1

# Set dircolors
if [[ "$(uname)" == "Darwin" ]]; then
    dc_cmd="gdircolors"
else
    dc_cmd="dircolors"
fi
if [[ -e ~/.dircolors ]]; then
    test -r ~/.dircolors && eval "$($dc_cmd -b ~/.dircolors)" || eval "$($dc_cmd -b)"
    # apply dircolors for zsh completion
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# source config files in .zshrc.d
if [[ -d ~/.zshrc.d ]]; then
    for i in ~/.zshrc.d/*.(sh|zsh); do
        if [[ -f $i ]]; then
            source $i
        fi
    done
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

