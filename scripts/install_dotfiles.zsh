#!zsh -e
setopt shwordsplit
cd ${0:a:h}/../
setup_path=`pwd`/dotfiles/

dotfiles=$(find $setup_path -mindepth 1 -maxdepth 1 -not -path "*.git*" -not -exec basename {} \;)
for file in $dotfiles; do
    out_file=~/.$file
    in_file=$setup_path$file
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
