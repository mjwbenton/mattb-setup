# mattb-setup osx scripts

A collection of OSX specific setup scripts.

## Unscripted setup

Before running any of these scripts, there some other stuff I normally do on a new mac that I don't have scripted.

- Check for any updates in the App Store
- Manually change display scaling to "More Space"
- Manually change hostname using System Settings > General > Sharing
- Manually turn on sound icon in menu bar using System Settings > Control Center > Sound
- Manually turn off Caps Lock using System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys
- Open Finder settings and...
  - Click show for all items on the Desktop
  - Go through sidebar items and show/hide whatever you want
- Right click on Finder toolbar, add the path item and remove the ones you won't use

## Scripted setup

- git clone this repo: `git clone https://github.com/mjwbenton/mattb-setup.git`
- `scripts/osx/install_rosetta.sh`
- `scripts/osx/setup_osx.bash`
- `scripts/osx/install_brews.zsh`
- Once all the software is installed...
  - You can run the non-OSX specific scripts
  - `scripts/osx/change_shell.zsh`
  - Manually configure Dropbox, Arq 5, Strongbox
  - fnm install --lts
- `scripts/osx/install_epsonscan.zsh`
