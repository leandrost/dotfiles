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
	function clr () 
  { 
    if [[ $2 == '\' ]]; then
      echo -e "\[\033[38;5;$1m\]"
    elif [ $# == '2' ]; then
        echo -e "\033[38;5;$1m$2\033[0m" 
    elif [ $# == '1' ]; then
      echo -e "\033[38;5;$1m"
    elif [ $# == '0' ]; then
      echo -e "\[\033[0m\]" 
    fi
  }
  function rvm_pp() { 
      prompt="$(~/.rvm/bin/rvm-prompt s)"
      if [[ $prompt == 'system' ]]; then
        prompt=''
      else
        prompt="[$prompt]"
      fi
      echo -e $(clr 9 "$prompt") 
  }
  function git_pp() { echo -e $(clr 229 "$(__git_ps1)"); }
  PS1="\u\$(clr 228 @\h) $(clr 229)\w\$(git_pp) \$(rvm_pp)\n$(clr 2 \\)$ $(clr)"
else
	PS1="\u@\h \w$(__git_ps1)\n$ "
fi
