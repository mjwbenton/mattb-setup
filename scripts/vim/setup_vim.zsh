#!zsh -e

# Assumes your vimrc is already in place which declares which plugins you want

# Install vim-plug
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Get undo directory setup
undo_dir=$HOME/.vim/undo
if ! [ -d $undo_dir ]; then
    mkdir -m 700 -p $undo_dir
fi

# coc.vim requires yarn
npm install -g yarn

# Install the plugins in the vimrc
vim +PlugInstall +qall
