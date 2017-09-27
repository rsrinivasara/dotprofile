#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM=xterm-256color
alias tmux="TERM=screen-256color /usr/bin/tmux"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/Caskroom"
export PATH=${PATH}:~/config-ram/dotprofile/bin

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# added by Anaconda3 4.4.0 installer
export PATH="/home/ram/anaconda3/bin:$PATH"
