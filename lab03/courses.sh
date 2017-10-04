#!/bin/bash

post="http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr="
under="http://www.handbook.unsw.edu.au/vbook2017/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr="

under+=$(echo $1|cut -c1)
post+=$(echo $1|cut -c1)

wget -q -O- $under |egrep "$1"|cut -d'>' -f2-3|cut -d'/' -f7-8|sed 's/.html">/ /'|sed 's/<\/A/ /'|egrep -Ev "^$"|egrep -v 'code|DIV'|sed 's/\s$//'>file
wget -q -O- $post |egrep "$1"|cut -d'>' -f2-3|cut -d'/' -f7-8|sed 's/.html">/ /'|sed 's/<\/A/ /'|egrep -Ev "^$"|egrep -v 'code|DIV'|sed 's/\s$//'>>file
sort -k1 file|sed 's/[ \t]*$//'|sed 's/<$//'|uniq
rm file
