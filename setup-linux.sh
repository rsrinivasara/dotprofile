# Cleanup
rm ~/.zshrc
rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.vim
rm -rf ~/.oh-my-zsh
rm -rf ~/repos/tux4life
rm -rf ~/repos/fonts
rm -rf ~/repos/tux4life
rm -rf ~/.tmux
# Clone required repos
git clone git@github.com:tux4life/tmux-config.git       ~/repos/tux4life/tmux-config
git clone git@github.com:tux4life/dotvim.git            ~/repos/tux4life/dotvim
git clone git@github.com:tux4life/dotprofile.git        ~/repos/tux4life/dotprofile
git clone https://github.com/powerline/fonts.git        ~/repos/fonts
git clone git://github.com/robbyrussell/oh-my-zsh.git   ~/.oh-my-zsh
https://github.com/tmux-plugins/tpm                     ~/.tmux/plugins/tpm
# Create required links
ln -s ~/repos/tux4life/dotprofile/zshrc       ~/.zshrc
ln -s ~/repos/tux4life/tmux-config/tmux.conf  ~/.tmux.conf
ln -s ~/repos/tux4life/dotvim/                ~/.vim
ln -s ~/repos/tux4life/dotvim/vimrc           ~/.vimrc
# Install fonts
~/repos/fonts/install.sh
