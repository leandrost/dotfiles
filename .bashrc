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

#git
alias ga='git add'

alias gs='git status'
alias gsu='git status --untracked-files=no'

alias gk='git checkout'
alias gkm='git checkout master'


alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -am'

alias rc='rails console'
#rake
alias rdbm='rake db:migrate'
alias rdbp='rake db:test:prepare'

#myfreecomm
alias fs='bundle exec foreman start -f Procfile.development'
alias integrate='RAILS_ENV=test time rake integrate && echo "NICE! Agora buzine duas vezes e apague o branch que vc integrou rapazinho!"'

if test -n "$(command -v pacman-color)"; then
	alias pacman='sudo pacman-color' 
fi

alias grep='grep --color=auto'
alias aur='aurget --noedit --asroot' 
alias trash='trash-put' 

export EDITOR=vim

source /usr/share/git/completion/git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=false
export GIT_PS1_SHOWUPSTREAM=auto

PATH=$PATH:$HOME/bin/
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [ $TERM = "xterm" ]
then
	function SET_COLOR () { echo -ne "\[\033[38;5;$1m\]"; }
	NO_COLOR='\[\033[0m\]'
	PS1="\u`SET_COLOR 228`@\h ${NO_COLOR}`SET_COLOR 229`\w\$(__git_ps1)\n${NO_COLOR}`SET_COLOR 2`$ ${NO_COLOR}"
else
	PS1="\u@\h \w$(__git_ps1)\n$ "
fi

[[ -s "/home/leandrost/.rvm/scripts/rvm" ]] && source "/home/leandrost/.rvm/scripts/rvm"
