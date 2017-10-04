#!/usr/bin/perl -w
$flag = 0;
$bools1 = $bools2 = 0;
@days = ('Mon', 'Tue', 'Wed', 'Thu', 'Fri');
@num = ('09', '10', '11','12', '13', '14', '15', '16', '17', '18', '19', '20');
foreach $Day (@days) {
    foreach $Time (@num) {
        $final{$Day}{$Time} = 0;
        $final2{$Day}{$Time} = 0;
    }
}
while(@ARGV) {
    $course = shift @ARGV;
    if($course eq '-d') {
        $flag = 1;
        next;
    }elsif($course eq '-t') {
        $flag = 2;
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
                    $prev = "";
                    while(@times) {
                        $thing = shift @times;
                        $thing =~ /([A-Za-z]{3}) ([0-9]{2}) - ([0-9]{2}) /;
                        $day = $1;
                        $beg = $2;
                        $end = $3;
                        if($flag == 1) {
                            $beg = 9 if $beg == "09";
                            $i = $beg;
                            while($i < $end) {
                                $final1{$sem." ".$course." ".$day." ".$i} += 1;
                                print"$sem $course $day $i\n" if $line =~ /\d/ &&  $final1{$sem." ".$course." ".$day." ".$i} == 1;   
                                $i++;
                            }
                        }else {
                            $i = $beg;
                            while($i < $end) {
                                    if($sem eq "S1") {
                                        $final{$day}{$i} += 1 if $prev ne $thing;
                                        $bools1 = 1;
                                    }
                                    if($sem eq "S2") {
                                        $final2{$day}{$i} += 1;
                                        $bools2 = 1;
                                    }
                                    $i++;
                            }
                            $prev = $thing;
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

if($flag == 2) {
    foreach $day (sort keys %final) {
        foreach $i (sort keys %{$final{$day}}) {
            $final{$day}{$i} = " " if $final{$day}{$i} == 0;
        }
    }
    foreach $day (sort keys %final2) {
        foreach $i (sort keys %{$final2{$day}}) {
            $final2{$day}{$i} = " " if $final2{$day}{$i} == 0;
        }
    }
    $num = "09";
    if($bools1 == 1) {
        print"S1       Mon   Tue   Wed   Thu   Fri\n";
        print"09:00     $final{Mon}{$num}     $final{Tue}{$num}     $final{Wed}{$num}     $final{Thu}{$num}     $final{Fri}{$num}\n";
        $i = 10;
        while($i < 21) {
            print"$i:00     $final{Mon}{$i}     $final{Tue}{$i}     $final{Wed}{$i}     $final{Thu}{$i}     $final{Fri}{$i}\n";
            $i++;
        }
    }
    if($bools2 == 1) {
        print"S2       Mon   Tue   Wed   Thu   Fri\n";
        print"09:00     $final2{Mon}{$num}     $final2{Tue}{$num}     $final2{Wed}{$num}     $final2{Thu}{$num}     $final2{Fri}{$num}\n";
        $i = 10;
        while($i < 21) {
            print"$i:00     $final2{Mon}{$i}     $final2{Tue}{$i}     $final2{Wed}{$i}     $final2{Thu}{$i}     $final2{Fri}{$i}\n";
            $i++;
        }
    }   
}
