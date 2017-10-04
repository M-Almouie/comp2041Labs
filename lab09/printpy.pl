#!/usr/bin/perl -w

$string = $ARGV[0];
$string =~ s/"/\"/;
push(@pyLines, "#!/usr/bin/python3");
$printLine = "print(\"";
$printLine .= "$string\")";
#print"String is $string\n";
if($printLine =~ /\\n/) {
    $printLine =~ s/\\n/\\\\n/;
}
print"now string is $printLine\n";
push(@pyLines, $printLine);
foreach $line(@pyLines) {
    print"$line\n";
}
