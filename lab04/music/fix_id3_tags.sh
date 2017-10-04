#!/bin/shell

album=`echo $1 |cut -d'/' -f2|sed 's/,.*//'`
year=`echo $1 |cut -d'/' -f2|sed 's/^.*, //'`

for f in `/music`
do
    if [ -d "$f" ]
    then
        for ff in `"$f"`
        do
            
        fi 
    fi
    echo $f
done
