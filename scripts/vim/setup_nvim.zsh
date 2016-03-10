#!zsh -e
# Requires setup_vim.zsh to have been run
ln -s ~/.vim/ ~/.config/nvim/
ln -s ~/.vimrc ~/.config/nvim/init.vim
pip2 install neovim
