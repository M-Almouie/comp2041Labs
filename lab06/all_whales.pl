#!/usr/bin/perl -w

@lines = <STDIN>;
chomp @lines;
$i=0;
while ($i < @lines)
{
    $name = $lines[$i];
    $name =~ s/^[0-9]+ //;
    $name =~ tr/A-Z/a-z/;
    $name =~ s/s$//;
    $name =~ s/^ +//;
    $name =~ s/ +$//;
    $name =~ s/ {2,}/ /;
    $num = $lines[$i];
    $num =~ s/ [a-z]+.*[a-z]*//i;
    $pods{"$name"}++;
    $individ{"$name"} += $num;
    $i++;
}
foreach $name (sort keys %pods)
{
    print "$name observations: $pods{$name} pods, $individ{$name} individuals\n"
}
