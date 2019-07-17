#mattb-setup osx scripts

A collection of OSX specific setup scripts.

## Unscripted setup

Before running any of these scripts, there some other stuff I normally do on a new mac that I don't have scripted.

- Check for any updates in the Mac Store
- Manually change display scaling to “More Space”
- Manually change hostname using System Preferences -> Sharing
- Manually turn on sound icon in menu bar using System Preferences -> Sound
- Manually turn off Caps Lock using System Preferences -> Keyboard -> Modifier Keys
- Open Finder preferences and...
  - Click show for all items on the Desktop
  - Go through sidebar items and show/hide whatever you want
- Right click on Finder toolbar, add the path item and remove the ones you won't use

## Scripted setup

- git clone this repo: `git clone https://github.com/mjwbenton/mattb-setup.git`
- `osx/scripts/setup_osx.bash`
- `osx/scripts/install_brews.zsh`
- Once all the software is installed...
  - You can run the non-OSX specific scripts
  - `osx/scripts/change_shell.zsh`
  - `osx/scripts/setup_iterm2.zsh`
  - Manually configure Dropbox, Crashplan
  - nvm install stable && nvm alias default stable
- `osx/scripts/install_epsonscan.zsh`
