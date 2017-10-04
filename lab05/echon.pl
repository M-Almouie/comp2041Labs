#!/usr/bin/perl -w
#Author:    Mohamed Daniel Al Mouiee
#Date:      22/08/2017

if (@ARGV != 2)
{
    print"Usage: ./echon.pl <number of lines> <string>\n"
}
elsif($ARGV[0] !~/^[0-9]+$/)
{
    print "./echon.pl: argument 1 must be a non-negative integer\n"
}
else
{
    $i = 0;
    while ($i < "$ARGV[0]")
    {
        print "$ARGV[1]\n";
        $i = $i + 1;
    }
}
