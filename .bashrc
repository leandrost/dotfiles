#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias grep='grep --color=auto'
alias pacman='sudo pacman-color' 

COLOR='[38;05;SETm'
NO_COLOR='[0m'

PS1='\u\e${COLOR//SET/227}@\h \e${COLOR//SET/229}\w \n\e${COLOR//SET/10}$\e${NO_COLOR} '
PATH=$PATH:bin/
