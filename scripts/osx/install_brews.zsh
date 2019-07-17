#!/usr/bin/env bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Need to make sure I'm in the folder of this script, which is where the Brewfile is
cd ${0:a:h}/
brew bundle --file=./Brewfile
