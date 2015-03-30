#!zsh -e

# mattb-setup root directory is always the directory above this script
cd ${0:a:h}/../

# Install the standard dotfiles first, then overwrite them with any local overrides
standard_path=`pwd`/dotfiles/
local_path=`pwd`/dotfiles.local/

function install_home_symlinks() {
    setopt shwordsplit
    file_path=$1
    files=$(find $file_path -mindepth 1 -maxdepth 1 -not -path "*.git*" -not -exec basename {} \;)
    for file in $files; do
        out_file=~/.$file
        in_file=$file_path$file
        if [ -h $out_file ] ; then
            echo "Deleting existing symlink: $out_file"
            rm $out_file
        fi
        if [ -f $out_file ]; then
            echo "Backed up existing: $out_file -> $out_file.bak"
            mv $out_file $out_file.bak
        fi
        ln -s $in_file $out_file
    done;
}

echo "Standard dotfiles installing..."
install_home_symlinks $standard_path

if [ -d $local_path ]; then
    echo "Local override dotfiles installing..."
    install_home_symlinks $local_path
fi
