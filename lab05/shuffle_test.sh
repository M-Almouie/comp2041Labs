#!/bin/sh

echo "Running First Test..."
echo "------------------------"
i=0;
while [ $i -lt 10 ]
do
    echo "$i">>temp
    i=`expr $i + 1`
done
./shuffle.pl<temp
rm temp
echo "Test 1 Complete..."
echo "Running Second Test ..."
echo "------------------------"
touch temp
./shuffle.pl<temp
echo "Test 2 Complete..."
echo "Tests all done"
rm temp
