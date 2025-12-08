#!/bin/zsh -e
# TODO: Move to a cask
url=https://ftp.epson.com/drivers/V700_V750_EScan2_64100_AM.dmg
output_dmg=/tmp/epsonscan.dmg
mount_point=/tmp/mountroot
installer="$mount_point/EPSON Scan 2.pkg"

echo "Fetching $url"
wget --quiet --output-document=$output_dmg $url

echo "Mounting $output_dmg to $mount_point"
mkdir -p $mount_point
hdiutil attach $output_dmg -mountpoint $mount_point

echo "Running Installer"
sudo installer -pkg $installer -target /

echo "Unmounting $output_dmg from $mount_point"
hdiutil detach $mount_point
rmdir $mount_point
rm $output_dmg
