# Cleanup
rm ~/.zshrc
rm ~/.tmux.conf
rm -rf ~/.oh-my-zsh
rm -rf ~/.tmux

# Cleanup nvim config
rm ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

mkdir -p ~/.config
mkdir -p ~/repos/tux4life

# Clone required repos
git clone git@github.com:tux4life/dotprofile.git ~/repos/tux4life/dotprofile
git clone git@github.com:rsrinivasara/nvim-config.git ~/repos/tux4life/nvim-config
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone git@github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/romkatv/powerlevel10k.git /home/ram/.oh-my-zsh/custom/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions /home/ram/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/ram/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Create required links
ln -s ~/repos/tux4life/dotprofile/zshrc ~/.zshrc
ln -s ~/repos/tux4life/dotprofile/tmux.conf ~/.tmux.conf
ln -s ~/repos/tux4life/nvim-config ~/.config/nvim
