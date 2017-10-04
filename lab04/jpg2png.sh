#!/bin/sh

for f in {.*,*}
do
    filename=`echo "$f"|sed 's/\.jpg//'`
    if [[ "$f" =~ .jpg$ ]]
    then
        if [ -e "$filename"".png" ]
        then
            echo "$filename.png already exists"
            exit 1
        else
            filename2="$filename"".png"
            convert "$f" "$filename2"
            rm "$f"
        fi
    fi
done
