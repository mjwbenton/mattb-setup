#!zsh -e

# mattb-setup root directory is always the directory above this script
cd ${0:a:h}/../

# Install the standard dotfiles first, then overwrite them with any local overrides
standard_path=`pwd`/dotfiles/
local_path=`pwd`/dotfiles.local/

function install_home_symlinks() {
    setopt shwordsplit
    file_path=$1
    cd $file_path

    # Create any directories that don't exist
    directories=$(find . -mindepth 1 -maxdepth 1 -not -path "*.git*" -type directory -exec basename {} \;)
    for dir in $directories; do
        out_dir=~/.$dir
        [ -d $out_dir ] || mkdir $out_dir
    done;

    # Install files
    files=$(find . -mindepth 1 -type file -not -path "*.git*")
    for file in $files; do
        file_stripped=`echo $file | cut -c3-`
        out_file=~/.$file_stripped
        in_file=$file_path$file_stripped
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
