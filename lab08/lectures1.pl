#!/usr/bin/perl -w
$flag = 0;
while(@ARGV) {
    $course = shift @ARGV;
    if($course eq '-d') {
        $flag = 1;
        next;
    }
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
                $field = $line;
                
                if($flag == 0) {
                    $final{$field} += 1;
                    print"$course: $sem $line\n" if $line =~ /\d/ &&  $final{$field} == 1;
                }else {
                    $line =~ s/\(Weeks:.*?\)//g;
                    $line =~ s/:[0-9]{2}//g;
                    @times = split(/, ?/,$line) if $line =~ /\d/;
                    while(@times) {
                        $thing = shift @times;
                        $thing =~ /([A-Za-z]{3}) ([0-9]{2}) - ([0-9]{2}) /;
                        $day = $1;
                        $beg = $2;
                        $end = $3;
                        $beg = 9 if $beg == "09";
                        $i = $beg;
                        while($i < $end) {
                            $final{$sem." ".$course." ".$day." ".$i} += 1;
                            print"$sem $course $day $i\n" if $line =~ /\d/ &&  $final{$sem." ".$course." ".$day." ".$i} == 1;   
                            $i++;
                        }
                    }
                }
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
