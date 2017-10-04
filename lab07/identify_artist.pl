#!/usr/bin/perl -w

foreach $file (glob "lyrics/*.txt") {
    open F, '<', $file;
    $artist = $file;
    $artist =~ s/\.txt//;
    $artist =~ s/lyrics\///;
    $artist =~ s/_/ /g;
    push(@artists,"$artist");
    $wordProb{$artist} = 0;
    while ($line = <F>)
    {
        @words = split /[^A-Za-z]+ */, $line;
        while (@words)
        {
            $word = shift @words;
            $word = lc($word);
            $wordCount{$artist}{$word} += 1;
        }
        @totalWords = split /[^A-Za-z]+ */, $line;
        $total{$artist} += @totalWords;
        if ($line =~ m/^[^A-Za-z]+ *[A-Za-z]/g )
        {
            $total{$artist} -= 1;
        }
    }
    $prob = log($wordProb{$artist}{$word})/($total{$artist});
    $wordProb{$artist}{$word} += $prob;
    close F;
}

foreach "$f" (@ARGV)
{
    open FILE, '<$f';
    while ($LINE = <FILE>)
    {
        @Words = split /[^A-Za-z]+ */, $Line;
        while (@Words)
        {
            $Word = shift @Words;
            $Word = lc($Word);
            $i =0;
            while ($i < @artist)
            {
                $final{$artist[i]}{$Word} += $wordProb{$artist[$i]}{$Word}
                $i++;
            }
        }
    }
    close FILE;
}

foreach $artist (sort keys %final)
{
    foreach $Word (sort values %{final{$Word}})
    {
        $highest = $final{$artist}{$Word} if ;
       
    }
}


print "$FILE most resembles the work of Adele (log-probability=$)";

