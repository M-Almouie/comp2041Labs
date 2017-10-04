#!/bin/shell

for f in $@
do
    if [ -e $f ]
    then
        mod=`ls -l $f|cut -d' ' -f5-|sed 's/^[ ]*[0-9]* //'|sed 's/[a-z]*[0-9]*_\?[0-9]*[a-z]*\.[a-z]*//'`
        convert -gravity south -pointsize 36 -draw "text 0,10 '$mod'" $f $f
    else
        echo "ERROR: $f does not exist..."
        exit 1
    fi
done
