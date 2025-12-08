mattb-setup dotfiles
====================

Files in this directory are symlinked into their correct directory using [`install_dotfiles.zsh`](../scripts/install_dotfiles.zsh). Any files in here can be overriden by creating a directory called `dotfiles.local` alongside the `dotfiles` directory. In addition many of the defaults here support an additional local file which gets imported into the main one. For example `config/fish/config.fish` will import `config.fish.local` if it exists giving you a way to extend the file on a per-machine basis.
