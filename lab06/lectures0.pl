#!/usr/bin/perl -w

$course = $ARGV[0];
$url = "http://timetable.unsw.edu.au/current/".$course.".html";
open F, "wget -q -O- $url|";
