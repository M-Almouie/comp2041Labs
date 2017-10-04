#!/usr/bin/perl -w
$i = 0;
while ($line = <STDIN>)
{
    @words = split /[^A-Za-z]+ */, $line;
    $i += @words;
    if ($line =~ m/^[^A-Za-z]+ *[A-Za-z]/g )
    {
        $i -= 1;
    }
}
print"$i words\n";
