#!/usr/bin/perl -w

sub varMapper {
	my ($var) = @_;
	@matches = $var =~ /([A-Za-z]+)/g;
	if(@matches) {
		foreach $word(@matches) {
			($first) = $word =~ /([A-Za-z]+)/;
			#print"first is $first\n";
			@identMat = $var =~ /($first)[^a-z]+/g;
			#print"id is $#identMat @identMat\n" if @identMat;
			if($#identMat > 0) {
			    #print"ha\n";
			    foreach $wor(@identMat) {
			        $var =~ s/$wor/\$$word/g if $var =~ /$wor/;
			    }
			}elsif($var =~ /$first/) {
			    $var =~ s/$first/\$$first/g; 
			}
			$var =~ s/\${2,}/\$/g;
		}
	}
	return $var;
}

open F, '<',$ARGV[0];
($fileName) = $ARGV[0] =~ /(.*\.)/;
@perlLines = ();
while($line = <F>) {
	chomp $line;
	if($line eq "") {
		push(@perlLines,"\n");
		next;
	}
	if($line =~ /\/bin\/bash/) {
		$line =~ s/\/bin\/bash/usr\/bin\/perl -w/;
		push(@perlLines,$line);
		next;
	}
	if($line =~ /echo/) {
		($cap) = $line =~ /echo (.*)/;
		$line =~ s/echo/print"/;
		$line =~ s/($cap)/$cap/;
		$line =~ s/$/\\n";/;
		push(@perlLines,$line);
		next;
	}
	if($line =~ /(fi$|do|then|done|else|elsif)/) {
		$line =~ s/do$/{/ if($line =~ /do$/);
		$line =~ s/then/{/ if($line =~ /then/);
		$line =~ s/done/}/ if($line =~ /done$/);
		$line =~ s/fi/}/ if($line =~ /fi$/);
		$line =~ s/else/}else{/ if($line =~ /else$/);
		$line =~ s/elsif/}/ if($line =~ /elsif$/);
		push(@perlLines,$line);
		next;
	}
	if($line =~ /[A-Za-z]+/ && !($line =~ /while|if/)) {
		$line = varMapper($line);
	}
	if($line =~ /while|if/) {
		($second) = $line =~ / \(\((.*)\)\)/;
		#print"loop line is $line\n";
		#print"second is $second\n";
		$second = varMapper($second);
		
		$line =~ s/if \(\(.*\)\)/if\($second\)/;
		$line =~ s/while \(\(.*\)\)/while\($second\)/;
		#$line =~ s/if \(\(.*\)\)/if\($second\)/;
	}
	if($line =~ /\$\(\(.*\)\)/) {
		($third) = $line =~ /\$\(\((.*)\)\)/;
		$third = varMapper($third);
		$line =~ s/\$\(\(.*\)\)/$third/;
	}
	$line =~ s/$/;/ if !($line =~ /while|if|{|}/);
	$line =~ s/\${2}/\$/;
	push(@perlLines,$line);
}
close F;
$fileName .= "pl";
open $F, '>', "$fileName" or die; 
$i=0;
foreach $Line(@perlLines) {
	print "$Line" if $Line ne "\n";
	print "\n" if $i < $#perlLines;
}
close $F;
