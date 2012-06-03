#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

shopt -s autocd

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -lh'

function make-completion-wrapper () {
  local function_name="$2"
  local arg_count=$(($#-3))
  local comp_function_name="$1"
  shift 2
  local function="
function $function_name {
  ((COMP_CWORD+=$arg_count))
  COMP_WORDS=( "$@" \${COMP_WORDS[@]:1} )
  "$comp_function_name"
  return 0
}"
  eval "$function"
}

#git
# usage: gitalias <alias> <original command>
function git_completion_wrapper() {
  make-completion-wrapper _git _$1 $2
  complete -o bashdefault -o default -o nospace -F _$1 $1
}

function git_alias () {
  alias $1="$2"
  git_completion_wrapper $1 $2
}

git_alias ga 'git add'

git_alias gs 'git status'
git_alias gsu 'git status --untracked-files no'

git_alias gk 'git checkout'
git_alias gkm 'git checkout master'

git_alias gc 'git commit'
git_alias gcm 'git commit -m'
git_alias gca 'git commit -a'
git_alias gcam 'git commit -am'

alias hit='git --git-dir=/home/leandrost/projects/dotfiles/.git/ --work-tree=/home/leandrost/'
git_completion_wrapper hit 'hit' 

alias ha='hit add'
alias hc='hit commit'
alias hs='git --git-dir=/home/leandrost/projects/dotfiles/.git/ --work-tree=/home/leandrost/ status --untracked-files=no'

#rake
alias rdbm='rake db:migrate'
alias rdbp='rake db:test:prepare'

#myfreecomm
alias rc='rails console'
alias fs='bundle exec foreman start -f Procfile.development'
alias integrate='RAILS_ENV=test time rake integrate && echo "NICE! Agora buzine duas vezes e apague o branch que vc integrou rapazinho!"'

if test -n "$(command -v pacman-color)"; then
	alias pacman='sudo pacman-color' 
fi

alias grep='grep --color=auto'
alias aur='pacaur' 
alias trash='trash-put' 

export EDITOR=vim

source /usr/share/git/completion/git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=false
export GIT_PS1_SHOWUPSTREAM=auto

PATH=$PATH:$HOME/bin/
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin/

if [ $TERM = "xterm" ]
then
	function SET_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }
	NO_COLOR='\[\033[0m\]'
	PS1="\u`SET_COLOR 228`@\h ${NO_COLOR}`SET_COLOR 229`\w\$(__git_ps1)\n${NO_COLOR}`SET_COLOR 2`$ ${NO_COLOR}"
else
	PS1="\u@\h \w$(__git_ps1)\n$ "
fi

[[ -s "/home/leandrost/.rvm/scripts/rvm" ]] && source "/home/leandrost/.rvm/scripts/rvm"
