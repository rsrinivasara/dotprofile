rm ~/.bash_profile 
rm ~/.emacs.d
rm ~/.spacemacs
rm ~/.zshrc
rm -rf ~/config-ram
mkdir ~/config-ram
git clone --recursive http://github.com/syl20bnr/spacemacs ~/config-ram/spacemacs
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git ~/config-ram/iterm-colors
ln -s ~/config-ram/spacemacs ~/.emacs.d
ln -s ~/config-ram/dotprofile/dot-spacemacs ~/.spacemacs
ln -s ~/config-ram/dotprofile/bash_profile ~/.bash_profile
ln -s ~/config-ram/dotprofile/zshrc ~/.zshrc
