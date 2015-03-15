#!zsh -e
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Make it so that we can use our Brewfile
brew tap 'homebrew/brewdler'
# Need to make sure I'm in the folder above this script, which is where the Brewfile is
cd ${0:a:h}/../
brew brewdle
