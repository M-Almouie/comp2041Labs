#!/usr/bin/perl -w
#Author:    Mohamed Daniel Al Mouiee
#Date:      22/08/2017

$i = 10;
foreach $arg (@ARGV) 
{
    if ($arg eq "--version") 
    {
        print "$0: version 0.1\n";
        exit 0;
    }
    elsif ($arg =~/^-[0-9]+/)
    {
        $i = substr $arg,1,2;
    }
    else 
    {
        push @files, $arg;
    }
}
if (@files == 0)
{
    @lines = <STDIN>;
    if (@lines < $i)
    {
        print "$_" for @lines;
    }
    else{
        $curr = @lines - $i;
        while ($curr < @lines)
        {
            print "$lines[$curr]" ;
            $curr = $curr + 1 ;
        }
    }
}else{
    $c = 0;
    foreach $f (@files) 
    {
        $c = $c + 1;
        if ($c <= @files && @files > 1)
        {
            print "==> $f <==\n"
        }
        open F, '<', $f or die "$0: Can't open $f: $!\n";
        @lines = <F>;
        if (@lines < $i)
        { 
            print "$_" for @lines;
        }
        else
        {
            $curr = @lines - $i;
            while ($curr < @lines)
            {
                print "$lines[$curr]" ;
                $curr = $curr + 1 ;
            }
        }
        close F;
    }
}

