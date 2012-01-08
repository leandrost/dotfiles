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
alias pacman='sudo pacman' 

PS1='\u@\h \W\$ '
