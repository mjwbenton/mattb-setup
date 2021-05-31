#!zsh -e
SHELLS_FILE=/etc/shells
NEW_SHELL=/usr/local/bin/fish
if ! [[ $(cat $SHELLS_FILE) =~ $NEW_SHELL ]]
then
    echo "Adding to /etc/shells. Root required"
    echo $NEW_SHELL | sudo tee -a /etc/shells
fi
chsh -s $NEW_SHELL
