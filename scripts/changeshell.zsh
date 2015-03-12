SHELLS_FILE=/etc/shells
NEW_SHELL=/usr/local/bin/zsh
if ! [[ $(cat $SHELLS_FILE) =~ $NEW_SHELL ]]
then
    echo $NEW_SHELL >> /etc/shells
fi && sudo -u matt chsh -s $NEW_SHELL
