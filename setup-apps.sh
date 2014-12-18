sudo mkdir /opt/Caskroom
sudo chown $USER:wheel /opt/Caskroom
brew tap caskroom/fonts
brew tap railwaycat/emacsmacport
brew install caskroom/cask/brew-cask

# Install brews
brew install $(cat brewfile|grep -v "#")

# Install casks
brew cask install $(cat caskfile|grep -v "#")
