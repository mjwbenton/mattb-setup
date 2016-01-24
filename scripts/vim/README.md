mattb-setup vim scripts
=======================

These scripts need to be run in a certain order.

1. [`setup_vim.zsh`](./setup_vim.zsh) - installs all the "vundles" that are in the vimrc, and creates any neccessary directories.
1. [`compile_youcompleteme.zsh`](./compile_youcompleteme.zsh) - the YouCompleteMe plugin requires an extra compilation step after install. It is only enabled on OSX in the config (as I've not got it to build with the version of vim I use on non-OSX machines), so there's no point running this on other machines.
1. [`install_tern.zsh`](./install_tern.zsh) - the tern plugin needs some npm dependencies installing. Again this is not enabled outside of OSX.
