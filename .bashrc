#!/usr/bin/env

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

shopt -s autocd

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

export EDITOR=vim

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -lh'
alias l.='ls -d .* --color=auto'

alias grep='grep --color=auto'
alias aur='pacaur' 
alias trash='trash-put' 
alias please='sudo'

if test -n "$(command -v pacman-color)"; then
  alias pacman='sudo pacman-color' 
fi

#add my scripts to path
PATH=$PATH:$HOME/bin/

source $HOME/.profiles/git
source $HOME/.profiles/perl
source $HOME/.profiles/ruby
source $HOME/.profiles/myfreecomm

if [ $TERM = "xterm" ]
then
	function SET_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }
	NO_COLOR='\[\033[0m\]'
	PS1="\u`SET_COLOR 228`@\h ${NO_COLOR}`SET_COLOR 229`\w\$(__git_ps1)\n${NO_COLOR}`SET_COLOR 2`$ ${NO_COLOR}"
else
	PS1="\u@\h \w$(__git_ps1)\n$ "
fi
