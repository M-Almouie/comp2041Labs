#!/bin/bash
# Author: mohamed Daniel Al Mouiee
# Date: 06/08/2017

if [ $# -ne 2 ]
then
    echo "Usage: ./echon.sh <number of lines> <string>"
    exit 1
fi

if [[ $1 =~ ^[A-Za-z]+$ ]]
then 
    echo "./echon.sh: argument 1 must be a non-negative integer"
    exit 1
fi

if [[ $1 = $1 ]]
then
    if [ "$1" -gt -1 ]
    then
	    if [ $# -eq 2 ]
	    then
		    n=$1
		    while [ $n -gt 0 ]
		    do
			    echo "$2"
			    n=`expr $n - 1`
		    done
	    fi
	else
	    echo "./echon.sh: argument 1 must be a non-negative integer"
	    exit 1
    fi
fi
