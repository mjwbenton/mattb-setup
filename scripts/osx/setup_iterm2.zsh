#!zsh -e

# This script requires you to have already setup dotfiles and installed iterm2

rm -rf ~/Library/Application\ Support/iTerm2/DynamicProfiles
mkdir -p ~/Library/Application\ Support/iTerm2
ln -s ~/.iterm2_profiles ~/Library/Application\ Support/iTerm2/DynamicProfiles
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "BFFDEB92-1D93-4D34-AA0D-11308E9209AE"
