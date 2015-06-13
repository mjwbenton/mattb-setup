#! zsh -e
download_path=/tmp/powerline-fonts
zip_path=$download_path/master.zip
install_script_path=$download_path/fonts-master/install.sh

mkdir $download_path
wget --quiet https://github.com/powerline/fonts/archive/master.zip --output-document $zip_path
unzip $zip_path -d $download_path
bash $install_script_path
rm -Rf $download_path
