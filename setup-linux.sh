# Cleanup
rm ~/.tmux.conf
rm -rf ~/.oh-my-zsh
rm -rf ~/.tmux

# Cleanup nvim config
rm -rf ~/repos/tux4life/nvim-config
rm ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

mkdir -p ~/.config
mkdir -p ~/repos/tux4life
mkdir -p ~/.tmux/plugins

# Clone required repos
git clone https://github.com/rsrinivasara/nvim-config.git ~/repos/tux4life/nvim-config

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/ohmyzsh.sh
chmod +x /tmp/ohmyzsh.sh
/tmp/ohmyzsh.sh --unattended
mkdir -p ~/.oh-my-zsh/custom/plugins
rm ~/.zshrc

git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Create required links
ln -s ~/repos/tux4life/dotprofile/zshrc ~/.zshrc
ln -s ~/repos/tux4life/dotprofile/tmux.conf ~/.tmux.conf
ln -s ~/repos/tux4life/nvim-config ~/.config/nvim
