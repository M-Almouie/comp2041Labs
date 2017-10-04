#!/usr/bin/perl -w

while(@ARGV) {
    $course = shift @ARGV;
    $url = "http://timetable.unsw.edu.au/current/".$course.".html";
    open F, "wget -q -O- $url|";
    $repeat = 0;
    $bool = 0;
    while($line = <F>) {
        chomp $line;
        if($repeat == 0) {
            if($bool == 1) {
                $bool = 0;
                $line =~ s/<td class="data">//;
                $line =~ s/<\/td>//;
                $line =~ s/^ +//;
                $final{$line} += 1;
                print"$course: $sem $line\n" if $line =~ /\d/ &&  $final{$line} == 1;
            }elsif($line =~ />lecture</i) {
                $line =~ s/<td class="data">//;
                $line =~ s/-[0-9]{4,}">Lecture<\/a><\/td>//;
                $line =~ s/<a href="#//;
                $line =~ s/^ +//;
                $sem = $line if $line =~ /\d/;
                $repeat = 6;
                $bool = 1;
            }
        }
        $repeat-- if $repeat > 0;
    }
}
