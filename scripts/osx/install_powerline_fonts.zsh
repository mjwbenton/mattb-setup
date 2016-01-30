#! zsh -e
download_path=/tmp/powerline-fonts
zip_path=$download_path/master.zip
install_script_path=$download_path/fonts-master/install.sh
input_mono_url="http://input.fontbureau.com/download/index.html?customize&fontSelection=fourStyleFamily&regular=InputMono-Regular&italic=InputMono-Italic&bold=InputMono-Bold&boldItalic=InputMono-BoldItalic&a=ss&g=ss&i=serifs&l=serifs&zero=slash&asterisk=0&braces=0&preset=monaco&line-height=1.2&email="

mkdir $download_path
wget --quiet https://github.com/powerline/fonts/archive/master.zip --output-document $zip_path
unzip $zip_path -d $download_path
bash $install_script_path
rm -Rf $download_path

echo "Download InputMono"
open $input_mono_url
echo "Manually set this font in iTerm. Remember to do both ASCII and non-ASCII settings!"
