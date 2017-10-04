#!/usr/bin/perl -w

$word = $ARGV[0];
$i = 0;
while ($line = <STDIN>)
{
    @words = split /[^A-Za-z]+ */, $line;
    while (@words)
    {
        $check = shift @words;
        $check =lc($check);
        if ($check eq $word)
        {
            $i += 1;
        }
    }
}
print"$word occurred $i times\n";
