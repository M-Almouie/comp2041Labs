#!/usr/bin/perl -w

$course=$ARGV[0];
$urlu = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/"."$course".".html";
$urlp = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/"."$course".".html";
push @curr, $course;
#print @curr, "\n";
$i =0 ;
while (@curr)
{
    $course = pop @curr;
    #print "$i + 1 iterartion curr has @curr\n"; 
    #print "Course is $course", "\n";
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
            $line =~ s/-CSE//;
            $line =~ s/^E .*//;
            $line =~ s/^BE .*//;
            $final .= "$line";
            @temp1 = split(/\n/,$final);
            push @curr, @temp1;
            #print "curr after web1 is @curr\n";
            last;
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
            $line1 =~ s/([()])//;
            $line1 =~ s/\]//;
            $final .= "$line1";
            @temp2 = split(/\n/,$final);
            push @curr, @temp2;
            last;
        }
    }
    #print "temp1 before push is @temp1\n";
    push @pres, @temp1 if @temp1;
    push @pres, @temp2 if @temp2;
    #print "After pop curr is @curr\n";
    #print "Now pres is @pres\n";
    #print "---------\n";
    #print $curr[0], "\n";
    $i++;
    $final = "";
    @temp1=();
    @temp2=();
}
close D;
#print"i is $i\n";
#push @pres, @curr;
$j=0;
while($j < $#pres+1)
{
    print"$pres[$j]\n";
    $j++;
}
