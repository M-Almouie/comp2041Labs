#!/usr/bin/perl -w
#Author:    Mohamed Daniel Al Mouiee
#Date:      22/08/2017

if (@ARGV != 0)
{
    foreach $arg (@ARGV)
    {
        push @files, $arg;
    }

    foreach $f (@files)
    {
        open F, '<', $f or die "$0: Can't open $f: $!\n";
        @lines = <F>;
        $i = 0;
        while ($i < @lines)
        {
            $ran = rand(@lines - 1);
            $temp = $lines[$i];
            $lines[$i] = $lines[$ran];
            $lines[$ran] = $temp;
            $i = $i + 1;
        }
        $curr = 0;
        while ($curr < @lines)
        {
            print "$lines[$curr]" ;
            $curr++;
        }
        close F;
    }
}
else
{
    @lines = <STDIN>;
    $i = 0;
    while ($i < @lines)
    {
        $ran = rand(@lines - 1);
        $temp = $lines[$i];
        $lines[$i] = $lines[$ran];
        $lines[$ran] = $temp;
        $i = $i + 1;
    }
    $curr = 0;
    while ($curr < @lines)
    {
        print "$lines[$curr]" ;
        $curr++;
    }
}

