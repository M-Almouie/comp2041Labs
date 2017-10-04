#!/usr/bin/perl -w

$course=$ARGV[0];
$urlu = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/"."$course".".html";
$urlp = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/"."$course".".html";
open F, "wget -q -O- $urlu|";
while ($line = <F>)
{
    if ($line =~ /Pre/)
    {
        $line =~ s/^[A-Z]{4}[0-9]{4}//;
        $line =~ s/<\/p>.*//;
        $line =~ s/<div.*<\/div>//;
        $line =~ s/<p>Prerequisite://;
        $line =~ s/<p>Pre://;
        $line =~ s/\s+//;
        $line =~ s/[a-z]*//;
        $line =~ s/\(.*\)//;
        $line =~ s/[a-z]*//g;
        $line =~ s/ {2,}/ /g;
        $line =~ s/ [0-9]{2} //;
        $line =~ s/<>P: //;
        $line =~ s/ /\n/g;
        $line =~ s/;//g;
        $line =~ s/,//g;
        $line =~ s/\.//g;
        $line =~ s/^$//;
        $final .= "$line";
    }
}
close F;
open D, "wget -q -O- $urlp|";
while ($line1 = <D>)
{
    if ($line1 =~ /Pre/)
    {
        $line1 =~ s/^[A-Z]{4}[0-9]{4}//;
        $line1 =~ s/<\/p>.*//;
        $line1 =~ s/<div.*<\/div>//;
        $line1 =~ s/<p>Prerequisite://;
        $line1 =~ s/<p>Pre://;
        $line1 =~ s/\s+//;
        $line1 =~ s/[a-z]*//;
        $line1 =~ s/\(.*\)//;
        $line1 =~ s/[a-z]*//g;
        $line1 =~ s/ {2,}/ /g;
        $line1 =~ s/ [0-9]{2} //;
        $line1 =~ s/<>P: //;
        $line1 =~ s/ /\n/g;
        $line1 =~ s/;//g;
        $line1 =~ s/,//g;
        $line1 =~ s/\.//g;
        $line1 =~ s/^$//;
        $final .= "$line1";
    }
}
close D;
print "$final";
