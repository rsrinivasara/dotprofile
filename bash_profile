export TERM=xterm-256color
alias vim=/usr/local/bin/vim
alias tmux="TERM=screen-256color /usr/bin/tmux"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/Caskroom"
export PATH=${PATH}:~/config-ram/dotprofile/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc
