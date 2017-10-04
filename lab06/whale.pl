#!/usr/bin/perl -w
while (@ARGV)
{
    $type .= shift @ARGV;
    $type .= " " if @ARGV;
}
@lines = <STDIN>;
chomp @lines;
$count = 0;
$i = 0;
$indiv=0;
while ($i < @lines)
{
    $name = $lines[$i];
    $name =~ s/^[0-9]+ //;
    $num = $lines[$i];
    $num =~ s/ [a-z]+.*[a-z]*//;
    if ("$name" eq "$type")
    {
        $count++;
        $indiv += $num; 
    }
    $i++;  
}
print "$type observations: $count pods, $indiv individuals\n"
