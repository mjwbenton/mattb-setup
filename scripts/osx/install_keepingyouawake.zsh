#!zsh -e
# TODO: Move to a cask
url=https://github.com/newmarcel/KeepingYouAwake/releases/download/1.2.1/KeepingYouAwake-1.2.1.zip
location_zip=/tmp/KeepingYouAwake.zip

echo "Fetching $url"
wget --quiet --output-document=$location_zip $url
echo "Unziping $location_zip"
unzip -qq $location_zip -d ~/Applications/
