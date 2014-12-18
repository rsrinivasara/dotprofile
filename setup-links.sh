rm ~/.bash_profile 
rm ~/.emacs.d
rm ~/.spacemacs
rm -rf ~/Documents/config-ram
mkdir ~/Documents/config-ram
git clone --recursive http://github.com/syl20bnr/spacemacs ~/Documents/config-ram/spacemacs
git clone https://github.com/tux4life/dot-spacemacs ~/Documents/config-ram/dot-spacemacs
ln -s ~/Documents/config-ram/spacemacs ~/.emacs.d
ln -s ~/Documents/config-ram/dot-spacemacs ~/.spacemacs
ln -s ~/Documents/dotprofile/bash_profile ~/.bash_profile
