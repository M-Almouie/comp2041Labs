#!/bin/sh
# Author: Mohamed Daniel Al Mouiee

for f in $@
do
    if [ -e $f ]
    then
        display $f
        echo "Address to e-mail this image to?"
        read email
        echo "Message to accompany image?"
        read mess
        echo mess|mutt -a "$f" -- $email
    else
        echo "$f cannot be displayed..."
        exit 1
    fi
done
