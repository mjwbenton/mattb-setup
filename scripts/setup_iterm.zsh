#!zsh -e
download_url=https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Molokai.itermcolors
download_path=/tmp/Molokai.itermcolors

echo "Downloading colorscheme"
wget --quiet --output-document=$download_path $download_url
echo "Loading colorscheme"
open $download_path
echo "Cleaning up colorscheme"
rm $download_path
