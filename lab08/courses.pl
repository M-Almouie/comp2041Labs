#!/usr/bin/perl -w

$code = $ARGV[0];
$url = "http://www.timetable.unsw.edu.au/current/".$code."KENS.html";
open F, "wget -q -O- $url|";
while($line = <F>) {
    chomp $line;
    if($line =~ /$code[0-9]{4}.html/) {
        $line =~ s/<td.*">//;
        $line =~ s/<\/a><\/td>//;
        $line =~ s/^ +//;
        print"$line\n" if $line =~ /$code[0-9]{4}/;
    }
}
close F;
