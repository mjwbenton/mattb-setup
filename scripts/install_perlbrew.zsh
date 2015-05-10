#!zsh -e
curl -L http://install.perlbrew.pl | bash
~/perl5/perlbrew/bin/perlbrew install-cpanm
echo "install a perl version with 'perlbrew install perl-5.xx.x'"
