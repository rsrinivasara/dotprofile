brew tap caskroom/fonts
brew install caskroom/cask/brew-cask
sudo chown $USER:wheel /opt/Caskroom

# Install brews
brew install $(cat brewfile|grep -v "#")

# Install casks
brew cask install $(cat caskfile|grep -v "#")
