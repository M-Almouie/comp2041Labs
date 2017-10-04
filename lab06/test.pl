#!/usr/bin/perl -w

while($line = <STDIN>) {
    $line =~ /^.html/;
    print"$line\n";
}
