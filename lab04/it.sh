#!/bin/sh
for file in {.*,*};
do
    echo "$file";
    filename=`echo "$file"|sed 's/\.jpg//'`
    echo $filename
done
