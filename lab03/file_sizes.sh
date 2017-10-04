#!/bin/sh
# Author: Mohamed Daniel Al Mouiee
# Date: 06/08/2017

small="Small files: "
med="Medium-sized files: "
large="Large files: "
for curr in `ls *`
do
	tempSize=$(wc -l <"$curr")
	if [ $tempSize -lt 10 ]
	then
		small+=$curr
		small+=" "
	elif [ $tempSize -lt 100 -a $tempSize  -gt 9 ]
	then
		med+=$curr
		med+=" "
	else
		large+=$curr
		large+=" "
	fi
done
echo $small
echo $med
echo $large
