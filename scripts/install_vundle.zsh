#!zsh -e

# Assumes your vimrc is already in place which declares which plugins you want

bundle_dir=$HOME/.vim/bundle
vundle_location=$bundle_dir/Vundle.vim
github_location=https://github.com/gmarik/Vundle.vim.git

# Get install directory setup
if ! [ -d $bundle_dir ]; then
    echo "bundle dir doesn't exist - creating"
    mkdir -p $bundle_dir
fi

# Install Vundle
if [ -e $vundle_location ]; then
    echo "already installed - skipping"
else
    git clone $github_location $vundle_location
fi

# Install the plugins in the vimrc
vim +PluginInstall +qall
