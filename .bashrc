#!/usr/bin/env

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function loadfile() {
  if [ -f $1 ]; then
    source $1
  fi
}

loadfile /etc/bash_completion

shopt -s autocd

##add my scripts to path
PATH=$PATH:$HOME/.local/bin

PATH=$PATH:$HOME/.yarn/bin

##ANDROID
export ANDROID_HOME=$HOME/apps/android-sdk

PATH=$PATH:$ANDROID_HOME/platform-tools/
PATH=$PATH:$ANDROID_HOME/emulator/
PATH=$PATH:$ANDROID_HOME/cmdline-tools/tools/bin

PATH=$PATH:$HOME/.kerl/bin
PATH=$PATH:$HOME/.kiex/bin
PATH=$PATH:$HOME/.cargo/bin

export EDITOR=vim

##ALIASES
alias ls='ls --color=auto'
alias lsd='ls --group-directories-first'
alias la='ls -a'
alias ll='ls -lh'
alias lld='lsd -lh'
alias lla='ls -lha'

alias grep='grep --color=auto'
alias cat="bat"

alias trash='trash-put'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

alias vim='vim --servername VIM'
alias vimt='vim --remote-tab-silent'
alias vimp='vim -p'

alias cdb='cd ~/projects/ballers/ballers-web'
alias cdg='cd ~/projects/got-board'
alias cdbp='cd ~/projects/beep'
alias cdp='cd ~/projects/'

alias ns='npm start'
alias ys='yarn start'
alias yb='yarn build'
alias yw='yarn watch'
alias yt='yarn test'

alias ef='env | fzf'

alias croc-update="curl https://getcroc.schollz.com | bash"

if test -n "$(command -v keychain)"; then
  alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && ssh'
  alias ssh-eval='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa)'
fi

alias service='sudo service'
alias apt='sudo apt'

if test -n "$(command -v google-chrome-stable)"; then
  alias chrome='google-chrome-stable'
fi

if test -n "$(command -v ack-grep)"; then
  alias ack='ack-grep'
fi

# DOCKER
alias dc="docker-compose"
alias dcu="dc up --detach"
alias docker-clear-volumes='docker volume ls -qf dangling=true | xargs -r docker volume rm'

##PROFILES
source $HOME/.profiles/git
source $HOME/.profiles/perl
source $HOME/.profiles/ruby

##PS1
if [ $TERM = "xterm-256color" ]
then
  function clr ()
  {
    if [[ $2 == '$' ]]; then
      echo -e "\[\033[38;5;$1m\]$\[\033[0m\]"
    elif [ $# == '2' ]; then
      echo -e "\033[38;5;$1m$2\033[0m"
    elif [ $# == '1' ]; then
      echo -e "\033[38;5;$1m"
    fi
  }
  function git_ps1()
  {
    color=147
    branch_info=$(__git_ps1)
    if [[ $branch_info == '' ]]; then
      return
    fi
    if [[ $branch_info =~ master.*$ ]]; then
      color=117
      branch_info=$(echo "$branch_info" | tr '[:lower:]' '[:upper:]')
    fi
    clr $color "$branch_info"
  }
  PS1="\u\$(clr 228 @\h) $(clr 229)\w\$(git_ps1)\n$(clr 75 $) "
else
  PS1="\u@\h \w$(__git_ps1)\n$ "
fi

##aws
if test -n "$(command -v aws)"; then
  complete -C '/usr/bin/aws_completer' aws
fi

##DIRENV
if test -n "$(command -v direnv)"; then
  eval "$(direnv hook bash)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

forgit_add=gaa
loadfile ~/.forgit/forgit.plugin.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[[ -s "/home/leandrost/.gvm/scripts/gvm" ]] && source "/home/leandrost/.gvm/scripts/gvm"
