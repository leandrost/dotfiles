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
alias ll='ls -lh'
alias gs='git status'
alias ga='git add'
alias gsu='git status --untracked-files=no'
alias gc='git commit'
alias gca='git commit -a'
alias grep='grep --color=auto'
alias pacman='sudo pacman-color' 
alias aur='aurget --noedit' 


export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

PATH=$PATH:bin/:/usr/lib/ruby/gems/1.9.1/gems/

if [ $TERM = "xterm" ]
then
	function SET_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }
	NO_COLOR='\[\033[0m\]'
	PS1="\u`SET_COLOR 228`@\h ${NO_COLOR}`SET_COLOR 229`\w$(__git_ps1)\n${NO_COLOR}`SET_COLOR 2`$ ${NO_COLOR}"
else
	PS1="\u@\h \w$(__git_ps1)\n$ "
fi

