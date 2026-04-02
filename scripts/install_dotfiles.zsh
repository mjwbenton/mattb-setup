#!/bin/zsh -e

# mattb-setup root directory is always the directory above this script
cd ${0:a:h}/../

dotfiles_path=`pwd`/dotfiles/

setopt shwordsplit
cd $dotfiles_path

# Create any directories that don't exist
directories=$(find . -mindepth 1 -not -path "*.git*" -type d | cut -c 3-)
for dir in $directories; do
    out_dir=~/.$dir
    [ -d $out_dir ] || mkdir -p $out_dir
done;

# Install files
files=$(find . -mindepth 1 -type f -not -path "*.git*")
for file in $files; do
    file_stripped=`echo $file | cut -c3-`
    out_file=~/.$file_stripped
    in_file=$dotfiles_path$file_stripped
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
