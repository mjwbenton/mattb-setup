#!/bin/zsh -e

mkdir -p ~/Library/Application\ Support/Code
rm -rf ~/Library/Application\ Support/Code/User
ln -s ~/.config/vscode ~/Library/Application\ Support/Code/User
