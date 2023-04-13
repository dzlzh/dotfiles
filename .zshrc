# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# export TERM="xterm-256color"
# export TERM=xterm

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
#
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo 111
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
plugins=(
    z
    git
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# E437: terminal capability "cm" required : export TERM=xterm

# export BROWSER='google-chrome-stable'
# export EDITOR='/bin/nvim'
# export GOPATH=$HOME
# export PATH=$PATH:$GOPATH/bin

alias mkdir='mkdir -pv'
alias vi='nvim'
alias vim='nvim'
alias lockpass='gpg-connect-agent reloadagent /bye'

# proxy
alias setproxy='export HTTPS_PROXY=http://127.0.0.1:7890 HTTP_PROXY=http://127.0.0.1:7890 ALL_PROXY=socks5://127.0.0.1:7890'
alias unsetproxy='unset HTTPS_PROXY HTTP_PROXY ALL_PROXY'

# Dotfiles
if [[ -d "$HOME/.dotfiles.git" ]]; then
    alias dfm="/usr/bin/git --git-dir .dotfiles.git --work-tree=$HOME"
fi

# 压缩
alias C=q-compress
funciton q-compress() {
    if [ -n "$1" ]; then
        FILE=$1
        case $FILE in
            *.tar) shift && tar -cf $FILE $* ;;
            *.tar.bz2) shift && tar -cjf $FILE $* ;;
            *.tar.xz) shift && tar -cJf $FILE $* ;;
            *.tar.gz) shift && tar -czf $FILE $* ;;
            *.taz) shift && tar -czf $FILE $* ;;
            *.zip) shift && zip $FILE $* ;;
            *.rar) shift && rar $FILE $* ;;
            *.7z) shift && 7z a $FILE $* ;;
        esac
    else
        echo "usage: C <file.tar.gz> ./file ./file2"
    fi
}

# 解压
alias Z=q-extract
function q-extract() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar) tar -xvf $1 ;;
            *.taz) tar -xvzf $1 ;;
            *.taz2) tar -xvjf $1 ;;
            *.tar.xz) tar -xvJf $1 ;;
            *.tar.gz) tar -xvzf $1 ;;
            *.tar.bz2) tar -xvjf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7x) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ipinfo.io
alias IP='curl ipinfo.io' # myip.ipip.net cip.cc ip-api.com

# bench.sh
alias T='wget -qO- bench.sh | bash'

# cht.sh
alias H=cht
function cht() {
    if [[ $1 ]]; then
        curl cht.sh/$1
    fi
}

# 删除改为移动
if [[ -d "$HOME/.trash/" ]]; then
    alias rm=trash
    function trash(){mv -f $@ $HOME/.trash/}
    function cleartrash(){/usr/bin/rm -rf $HOME/.trash/*}
fi

# FZF
if [[ -f "$HOME/.fzf.zsh" ]]; then
    source $HOME/.fzf.zsh
fi
if [[ -x "/usr/bin/fzf" ]]; then
    alias vimf='nvim $(fzf)'
    alias catf='bat $(fzf)'
    alias gcf='git checkout $(git branch | fzf)'
    alias gcfa='git checkout $(git branch -a | fzf)'
    alias gdf='git branch -D $(git branch | fzf)'
fi

# ag
if [[ -x "/usr/bin/ag" ]]; then
    export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
fi

# bat
if [[ -x "/usr/bin/bat" ]]; then
    alias cat='bat --paging=never' # https://github.com/sharkdp/bat
fi

# exa
if [[ -x "/usr/bin/exa" ]]; then
    alias ls='exa' # https://github.com/ogham/exa
    alias l='exa -lh'
    alias ll='exa -lh'
    alias la='exa -lha'
fi

# xrandr
if [[ -x "/usr/bin/xrandr" ]]; then
    alias xrandrone='xrandr --output eDP1 --primary --auto --output HDMI1 --off'
    alias xrandrtowl='xrandr --output eDP1 --primary --auto --output HDMI1 --auto --left-of eDP1'
    alias xrandrtowr='xrandr --output eDP1 --primary --auto --output HDMI1 --auto --right-of eDP1'
fi

# aria2
if [[ -x "/usr/bin/aria2c" ]]; then
    alias aria2='aria2c --enable-rpc --rpc-listen-all --rpc-allow-origin-all --conf-path=$HOME/.config/aria2/aria2.conf'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "$HOME/.p10k.zsh" ]] || source $HOME/.p10k.zsh

# Golang
if [[ ! -f "$HOME/.go/bin/goup" ]]; then
    curl -sSf https://raw.githubusercontent.com/owenthereal/goup/master/install.sh | sh -s -- '--skip-prompt'
fi
[[ ! -f "$HOME/.go/env" ]] || source $HOME/.go/env

# Local
[[ ! -f "$HOME/.zshrc.local" ]] || source $HOME/.zshrc.local
