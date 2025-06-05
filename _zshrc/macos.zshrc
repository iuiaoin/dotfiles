# ===================================================== #
#  _____            _               ______              #
# |  __ \          | |             |  ____|             #
# | |  | | ___  ___| | __ _ _ __   | |__   _ ____   __  #
# | |  | |/ _ \/ __| |/ _` | '_ \  |  __| | '_ \ \ / /  #
# | |__| |  __/ (__| | (_| | | | | | |____| | | \ V /   #
# |_____/ \___|\___|_|\__,_|_| |_| |______|_| |_|\_/    #
#                                                       #
# ===================================================== #

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Enable insecure directories and files from custom plugins
# ZSH_DISABLE_COMPFIX="true"

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
export UPDATE_ZSH_DAYS=30

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# This speed up zsh-autosuggetions by a lot
export ZSH_AUTOSUGGEST_USE_ASYNC="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fzf-tab
  zsh-autosuggestions
  fast-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh

if [ "$(uname -m)" = "arm64" ]; then
    fpath+=/opt/homebrew/share/zsh/site-functions
fi

autoload -U promptinit; promptinit
prompt pure

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set NPM Global Path
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
# Create .npm-global folder if not exists
[[ ! -d "$HOME/.npm-global" ]] && mkdir -p $HOME/.npm-global

export BAT_THEME="Monokai Extended Bright"
export HOMEBREW_NO_AUTO_UPDATE=1

export PNPM_HOME=~/.pnpm
# Path should be set before fnm
export PATH="/usr/local/opt/curl/bin:$HOME/.yarn/bin:$NPM_CONFIG_PREFIX/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$PNPM_HOME:$HOME/.local/bin:$PATH"

# fnm automatically switch Node.js versions when you cd into a directory with a .node-version or .nvmrc file
if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# Lazyload Function

## Setup a mock function for lazyload
## Usage:
## 1. Define function "_declan_lazyload_command_[command name]" that will init the command
## 2. declan_lazyload_add_command [command name]
declan_lazyload_add_command() {
    eval "$1() { \
        unfunction $1; \
        _declan_lazyload_command_$1; \
        $1 \$@; \
    }"
}

## Lazyload thefuck
if (( $+commands[thefuck] )) &>/dev/null; then
    _declan_lazyload_command_fuck() {
        eval $(thefuck --alias)
    }

    declan_lazyload_add_command fuck
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias pip=pip3
if (( $+commands[code] )); then
    alias zshconfig="code $HOME/.zshrc"
else
    alias zshconfig="vim $HOME/.zshrc"
fi

alias rezsh="omz reload"
alias rmrf="rm -rf"
alias gitcm="git commit -m"
alias gitp="git push"
alias gita="git add -a"
alias gitall="git add ."
# Git Undo
alias git-undo="git reset --soft HEAD^"

# Enable sudo in aliased
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

alias q="cd $HOME && clear"

alias digshort="dig @1.0.0.1 +short "

alias restart_bluetooth="sudo pkill bluetoothd && sudo launchctl start com.apple.bluetoothd"

alias finder_show="defaults write com.apple.finder AppleShowAllFiles YES"
alias finder_hide="defaults write com.apple.finder AppleShowAllFiles NO"
alias getip="ipconfig getifaddr en0"

# use cd ~desktop to quickly change to your Desktop directory
hash -d desktop="$HOME/Desktop"
hash -d music="$HOME/Music"
hash -d pictures="$HOME/Pictures"
hash -d picture="$HOME/Pictures"
hash -d downloads="$HOME/Downloads"
hash -d download="$HOME/Downloads"
hash -d documents="$HOME/Documents"
hash -d document="$HOME/Documents"

IPv6on() {
    echo "🟢 Enabling IPv6 on Wi-Fi and restarting adapter..."
    sudo networksetup -setv6automatic Wi-Fi
    sudo networksetup -setnetworkserviceenabled Wi-Fi off
    sudo networksetup -setnetworkserviceenabled Wi-Fi on
    echo "✅ IPv6 enabled on Wi-Fi and adapter restarted"
}

IPv6off() {
    echo "🔴 Disabling IPv6 on Wi-Fi and restarting adapter..."
    sudo networksetup -setv6off Wi-Fi
    sudo networksetup -setnetworkserviceenabled Wi-Fi off
    sudo networksetup -setnetworkserviceenabled Wi-Fi on
    echo "✅ IPv6 disabled on Wi-Fi and adapter restarted"
}

# Activate Python env
orange() {
    echo "🐍 Activating Python virtualenv: openai"
    source ~/.virtualenvs/openai/bin/activate
    echo "✅ Python virtualenv 'openai' activated"
}

# Deactivate Python env
unorange() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "🚫 Deactivating Python virtualenv: $(basename $VIRTUAL_ENV)"
        deactivate
        echo "✅ Python virtualenv deactivated"
    else
        echo "ℹ️ No active Python virtualenv to deactivate"
    fi
}

clear_dns_cache() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    sudo killall mDNSResponderHelper
}
alias flushdns="clear_dns_cache"

git-config() {
    echo -n "
===================================
      * Git Configuration *
-----------------------------------
Please input Git Username: "

    read username

    echo -n "
-----------------------------------
Please input Git Email: "

    read email

    echo -n "
-----------------------------------
Done!
===================================
"

    # git config --global alias.lg "log --graph --abbrev-commit --decorate --all --format=format:\"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)\""
    git config --global user.name "${username}"
    git config --global user.email "${email}"
}

# fix permission issues when trying to install, upgrade, or remove software with Homebrew.
brew-fix() {
    sudo chown -R $(whoami) /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
    chmod u+w /usr/local/include /usr/local/lib /usr/local/lib/pkgconfig
}

# Kills a process running on a specified tcp port
killport() {
  echo "Killing process on port: $1"
  fuser -n tcp -k $1;
}

extract() {
    if [[ -f $1 ]]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar e $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# hexo completion
if (( $+commands[hexo] )) &>/dev/null; then
    _hexo_completion() {
        compls=$(hexo --console-list)
        completions=(${=compls})
        compadd -- $completions
    }

    compdef _hexo_completion hexo
fi

# npm completion
if (( $+commands[npm] )) &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
fi

# fzf
if (( $+commands[fzf] )) &>/dev/null; then
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
fi

# conda
if (( $+commands[conda] )) &>/dev/null; then
  # lazyload conda
  __declan_lazy_conda_aliases=('python' 'conda' 'pip' 'pip3' 'python3')
  for lazy_conda_alias in $__declan_lazy_conda_aliases
  do
    alias $lazy_conda_alias="__declan_load_conda && $lazy_conda_alias"
  done

  __declan_load_conda() {
    for lazy_conda_alias in $__declan_lazy_conda_aliases
    do
        unalias $lazy_conda_alias
    done
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    if [ "$(uname -m)" = "arm64" ]; then
        __homebrew_prefix="/opt/homebrew"
    else
        __homebrew_prefix="/usr/local"
    fi
    __conda_setup="$('"$__homebrew_prefix/Caskroom/miniconda/base/bin/conda"' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$__homebrew_prefix/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "$__homebrew_prefix/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="$__homebrew_prefix/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    # export PATH="/usr/local/miniconda3/bin:$PATH"  # commented out by conda initialize

    unfunction __declan_load_conda
  }
fi

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)
# Enable completion in zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=1