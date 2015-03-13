#!/bin/bash
SETUP_PATH=~/mattb-setup/dotfiles

FILES=$(find $SETUP_PATH -mindepth 1 -maxdepth 1 -not -path "*.git*" -not -exec basename {} \;)
for FILE in $FILES; do
    OUT_FILE=~/.$FILE
    IN_FILE=$SETUP_PATH/$FILE
    if [ -e $OUT_FILE ] ; then
        rm $OUT_FILE
    fi
    ln -s $IN_FILE $OUT_FILE
done;
