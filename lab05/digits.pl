#!/usr/bin/perl -w
#Author:    Mohamed Daniel Al Mouiee
#Date:      22/08/2017

if (@ARGV != 0)
{
        foreach $arg (@ARGV)
        {
                $arg=~ tr/01234/</;
                printf "$arg";
        }
}
else
{
        @argg = <STDIN>;
        tr/01234/</ foreach (@argg);
        tr/6789/>/ foreach (@argg);
        print @argg;
}
