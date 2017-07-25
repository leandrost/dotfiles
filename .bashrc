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

##ANDROID
PATH=$PATH:/opt/android-sdk/platform-tools/
PATH=$PATH:/opt/android-sdk/tools/
export ANDROID_HOME=/opt/android-sdk

export EDITOR=vim

#function make-completion-wrapper () {
  #local function_name="$2"
  #local arg_count=$(($#-3))
  #local comp_function_name="$1"
  #shift 2
  #local function="
#function $function_name {
  #((COMP_CWORD+=$arg_count))
  #COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
  #"$comp_function_name"
  #return 0
#}"
  #eval "$function"
#}

#source $HOME/.npm_completion

##ALIASES
alias ls='ls --color=auto'
alias lsd='ls --group-directories-first'
alias la='ls -a'
alias ll='ls -lh'
alias lld='ll --group-directories-first'
alias lla='ls -lha'
alias l.='ls -d .* --color=auto'

alias grep='grep --color=auto'
alias pac='packer --noedit'
alias trash='trash-put'
alias please='sudo'
alias cdl='cd ~/projects/lista-amiga/'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias diskspace='dfc'
#deve checkar antes se o vim instalado tá habilitado (instalar vim-gnome)
alias vim='vim --servername VIM'
alias vimt='vim --remote-tab-silent'
alias vimp='vim -p'
alias np='node_modules/.bin/mocha -R nice-spec'
alias ttpt='normit en pt'
alias tten='normit pt en'
alias lockscreen='gnome-screensaver-command -l'
alias cdb='cd ~/projects/ballers/ballers-web'
alias cdg='cd ~/projects/got-board'

alias ns='npm start'
alias ys='yarn start'
alias yb='yarn build'
alias yw='yarn watch'
alias yt='yarn test'

alias todo='vimt /home/leandrost/.local/share/todo.txt/todo.txt'

if test -n "$(command -v keychain)"; then
  alias ssh='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa) && ssh'
  alias ssh-eval='eval $(/usr/bin/keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa)'
fi

if test -n "$(command -v pacman-color)"; then
  alias pacman='sudo pacman-color'
else
  alias pacman='sudo pacman'
fi
alias npe='PATH=$(npm bin):$PATH'
alias apt-get='sudo apt-get'
alias service='sudo service'

if test -n "$(command -v google-chrome-stable)"; then
  alias chrome='google-chrome-stable'
fi

if test -n "$(command -v ack-grep)"; then
  alias ack='ack-grep'
fi

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ember=node_modules/.bin/ember

alias dc="docker-compose"
alias dcu="dc up"
alias dcd="dc down"
alias dce="dc exec"
alias dcr="dc run --rm"
alias disable-bracketed='printf "\e[?2004l"'

##PROFILES
source $HOME/.profiles/git
source $HOME/.profiles/perl
source $HOME/.profiles/ruby
source $HOME/.profiles/myfreecomm

##PS1
if [ $TERM = "xterm" ]
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

##ELASTICSEARCH
export ELASTICSEARCH_CONFIG_PATH="/etc/elasticsearch"
export ELASTICSEARCH_BIN="/usr/share/elasticsearch/bin/elasticsearch"
export ELASTICSEARCH_CONFIG="$ELASTICSEARCH_CONFIG_PATH/elasticsearch.yml"
export ES_CLASSPATH="$ELASTICSEARCH_CONFIG_PATH/logging.yml"

##CUSTOM PATH
#HEROKU_PATH=/usr/local/heroku/bin
#PHANTOMJS_PATH=/opt/phantomjs/phantomjs-1.9.1/bin

##export LC_CTYPE=pt_BR.UTF-8
##export LC_ALL=pt_BR.UTF-8

##DIRENV
if test -n "$(command -v direnv)"; then
  eval "$(direnv hook bash)"
fi

##AUTOENV
#if test -n "$(command -v autoenv)"; then
  #source ~/.autoenv/activate.sh
#fi

##aws
if test -n "$(command -v aws)"; then
  complete -C '/usr/bin/aws_completer' aws
fi

##DOCKER
alias docker-clear-volumes='docker volume ls -qf dangling=true | xargs -r docker volume rm'

docker-ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}

source ~/.dvm/dvm.sh


#PATH=$PATH:$HEROKU_PATH:$PHANTOMJS_PATH

export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

