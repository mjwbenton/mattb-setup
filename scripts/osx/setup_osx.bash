#!/usr/bin/env bash

# Based on https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# and https://gist.github.com/brandonb927/3195465

# ----- Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# ----- Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# ----- Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# ----- Enable filename extensions in finder and disable extension change warning
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ----- Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ----- Show the ~/Library and /Volumes folders
chflags nohidden ~/Library
sudo chflags nohidden /Volumes

# ----- Clear all applications from the dock, change the tilesize and autohide
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock tilesize -int 44
defaults write com.apple.dock autohide -bool true

# ----- Play feedback when volume is changed
defaults write -g "com.apple.sound.beep.feedback" -int 1

# ----- Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# ----- Hotcorners
# Top right screen corner → Screensaver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0

# ----- Show battery percentage in menu bar
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# ----- Kill affected apps to get them to restart
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done
