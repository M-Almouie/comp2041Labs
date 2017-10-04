#!/usr/bin/perl -w

$test = $ARGV[0];
print"test is $test\n";
if ($test =~ /\\n/)
{
    print"NOO\n";
    $test =~ s/\\n/\\\\n/;
}
print"now test is $test\n";
print"\\\\n\n";
