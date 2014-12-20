rm ~/.bash_profile 
rm ~/.emacs.d
rm ~/.spacemacs
rm ~/.zshrc
rm -rf ~/Documents/config-ram
mkdir ~/Documents/config-ram
git clone --recursive http://github.com/syl20bnr/spacemacs ~/Documents/config-ram/spacemacs
git clone https://github.com/tux4life/dot-spacemacs ~/Documents/config-ram/dot-spacemacs
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/Documents/config-ram/iterm-colors
ln -s ~/Documents/config-ram/spacemacs ~/.emacs.d
ln -s ~/Documents/config-ram/dot-spacemacs/dot-spacemacs ~/.spacemacs
ln -s ~/Documents/dotprofile/bash_profile ~/.bash_profile
ln -s ~/Documents/dotprofile/zshrc ~/.zshrc
