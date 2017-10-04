#!/usr/bin/perl -w
$word = $ARGV[0];
foreach $file (glob "lyrics/*.txt") {
    open F, '<', $file;
    $name = $file;
    $name =~ s/\.txt//;
    $name =~ s/lyrics\///;
    $name =~ s/_/ /g;
    $artist{$name} = 0;
    while ($line = <F>)
    {
        @words = split /[^A-Za-z]+ */, $line;
        while (@words)
        {
            $check = shift @words;
            $check = lc($check);
            if ($check eq $word)
            {
                $artist{$name} += 1;
            }
        }
        @totalWords = split /[^A-Za-z]+ */, $line;
        $total{$name} += @totalWords;
        if ($line =~ m/^[^A-Za-z]+ *[A-Za-z]/g )
        {
            $total{$name} -= 1;
        }
    }
}

foreach $name (sort keys %artist)
{
    printf("log((%d + 1)/%6d) = %8.4f %s\n",$artist{$name},$total{$name},log(($artist{$name}+1)/$total{$name}),$name);
}
