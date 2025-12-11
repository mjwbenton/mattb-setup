---
# cSpell:words mattb daisydisk autofilling epsonscan mjwbenton mattbook cocatalog
---
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
- `scripts/osx/install_brews.zsh`
- `scripts/osx/setup_osx.bash`
- Once all the software is installed...
  - You can run the non-OSX specific scripts
  - `scripts/osx/change_shell.zsh`
  - Manually configure Dropbox, Arq 5, Strongbox
  - fnm install --lts
- `scripts/osx/install_epsonscan.zsh`
- `scripts/osx/install_store.zsh`

## Next Steps

- Login to Dropbox
- Login to Claude
- Login to Claude Code
- Login to Notion
- Manually configure Arq

## Node

- `fnm install --lts`
- `corepack enable`

### Phoenix

- `scripts/osx/setup_phoenix.zsh`
- Start Phoenix and give it accessibility access

### Strongbox

- Startup and connect to Dropbox
- In "Autofill & Passwords" turn off autofilling from the Passwords app and turn on autofilling from Strongbox

### Daisydisk

- Enter daisydisk license key (search "daisydisk" in gmail)

### VSCode

- `scripts/osx/setup_vscode.zsh`
- `scripts/install_vscode_extensions.zsh`

### Safari

- Login to Gmail and Google Calendar
- For Each `File > Add to Dock`
- Open extension settings and ensure they're all enabled

### Change Setup Repo Remote

- Once you've got SSH keys setup
- git remote set-url origin ssh://git@github.com/mjwbenton/mattb-setup.mattbook.git
- git remote set-url origin ssh://git@github.com/mjwbenton/mattb-setup.git

### Capture One

- Copy over the catalog file (\~/Pictures/Capture One Catalog.cocatalog) and settings (\~/Library/Application Support/Capture One)
