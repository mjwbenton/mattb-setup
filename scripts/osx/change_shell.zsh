#!zsh -e
SHELLS_FILE=/etc/shells
NEW_SHELL=/usr/local/bin/zsh
if ! [[ $(cat $SHELLS_FILE) =~ $NEW_SHELL ]]
then
    sudo echo $NEW_SHELL >> /etc/shells
fi
chsh -s $NEW_SHELL
