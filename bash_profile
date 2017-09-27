export TERM=xterm-256color
alias vim=/usr/local/bin/vim
alias tmux="TERM=screen-256color /usr/bin/tmux"
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/opt/Caskroom"
export PATH=${PATH}:~/config-ram/dotprofile/bin:~/Work/mactoolkit/
TOOLKIT_USERNAME=rsriniva
alias dev_proxy='http_proxy=http://bproxy.tdmz1.bloomberg.com:80 https_proxy=http://bproxy.tdmz1.bloomberg.com:80'
alias git_proxy='http_proxy=http://proxy.bloomberg.com:80 https_proxy=http://proxy.bloomberg.com:80'
alias ext_proxy='http_proxy=http://proxy.bloomberg.com:77 https_proxy=http://proxy.bloomberg.com:77'

[[ -f ~/.bashrc ]] && . ~/.bashrc
