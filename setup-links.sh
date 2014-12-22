rm ~/.bash_profile 
rm ~/.emacs.d
rm ~/.spacemacs
rm ~/.zshrc
rm ~/.tmuxrc.conf
mkdir ~/config-ram
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone --recursive http://github.com/syl20bnr/spacemacs ~/config-ram/spacemacs
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/config-ram/iterm-colors
ln -s ~/config-ram/spacemacs ~/.emacs.d
ln -s ~/config-ram/dotprofile/dot-spacemacs ~/.spacemacs
ln -s ~/config-ram/dotprofile/bash_profile ~/.bash_profile
ln -s ~/config-ram/dotprofile/zshrc ~/.zshrc
ln -s ~/config-ram/dotprofile/tmux.conf ~/.tmux.conf
