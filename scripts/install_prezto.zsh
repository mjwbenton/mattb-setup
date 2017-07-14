#!zsh -e

# Checkout prezto
install_path=$HOME/.zprezto
if ! [ -e $install_path ]
then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
fi

# Gets all files in setup_path which we want to symlink into the home dir, ignoring:
#  - README.md - just prezto documentation
#  - zshrc - we'll put our own customizations after the sourcing of prezto
#            so store it with our dotfiles
#  - zpreztorc - pretzo configuration needs to be modified, so again lives with the dotfiles
setup_path=$install_path/runcoms
files=($(find $setup_path/* -not -name README.md -not -name zshrc -not -name zpreztorc -not -name zlogout -exec basename {} \;))

# Symlink the files into place
for file in $files; do
    out_file=~/.$file
    in_file=$setup_path/$file
    # Delete any symlinks
    if [ -h $out_file ]; then
        echo "Deleting existing symlink: $out_file"
        rm $out_file
    fi
    # Backup any real files that we need to back up
    if [ -f $out_file ]; then
        echo "Backed up existing: $out_file -> $out_file.bak"
        mv $out_file $out_file.bak
    fi
    ln -s $in_file $out_file
done
