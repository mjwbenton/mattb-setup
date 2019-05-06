#!/usr/bin/env bash

# Based on https://github.com/mathiasbynens/dotfiles/blob/master/.osx
# and https://gist.github.com/brandonb927/3195465

# ----- No sound effect on boot
sudo nvram SystemAudioVolume=" "

# ----- Change Spotlight search results
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
# Load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# Make sure indexing is turned off for all additional volumes
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

# ----- Enable filename extensions in finder and disable extension change warning
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ----- Don't create .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ----- Clear all applications from the dock, change the tilesize and autohide
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock tilesize -int 44
defaults write com.apple.dock autohide -bool true

# ----- Lower the font smoothing level a little
defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# ----- Play feedback when volume is changed
defaults write -g "com.apple.sound.beep.feedback" -int 1

# ----- Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# ----- Kill affected apps to get them to restart
for app in "cfprefsd" "Dock" "Finder" "SystemUIServer"; do
    killall "${app}" > /dev/null 2>&1
done
