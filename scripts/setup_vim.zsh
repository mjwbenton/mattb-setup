#!zsh -e

# Assumes your vimrc is already in place which declares which plugins you want

bundle_dir=$HOME/.vim/bundle
undo_dir=$HOME/.vim/undo
vundle_location=$bundle_dir/Vundle.vim
vundle_github_location=https://github.com/gmarik/Vundle.vim.git

# Get install directory setup
if ! [ -d $bundle_dir ]; then
    echo "bundle dir doesn't exist - creating"
    mkdir -p $bundle_dir
fi

# Get undo directory setup
if ! [ -d $undo_dir ]; then
    echo "undo dir doesn't exist - creating"
    mkdir -m 700 -p $undo_dir
fi

# Install Vundle
if [ -e $vundle_location ]; then
    echo "already installed - skipping"
else
    git clone $vundle_github_location $vundle_location
fi

# Install the plugins in the vimrc
vim +PluginInstall +qall
