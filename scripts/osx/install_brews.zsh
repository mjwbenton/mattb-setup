#!/bin/zsh -e
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Need to make sure I'm in the folder of this script, which is where the Brewfile is
cd ${0:a:h}/
/opt/homebrew/bin/brew bundle --file=./Brewfile
