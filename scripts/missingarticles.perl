#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $counter = 0;
my %importhash;
my @missingArray;

my $filename = 'export.xml';

open(my $fh, '<', $filename)
  	or die "Could not open file '$filename' $!";
 
while (my $row = <$fh>) {
  	chomp $row;
  	

  	if ($row =~ /<a href="([^"]+)" title="[^"]+">source<\/a>/) {
		$counter = $counter + 1;
		$importhash{$1} = undef;
	}

}

close($fh);

$filename = 'import.xml';

open(my $fh, '<', $filename)
  	or die "Could not open file '$filename' $!";
 
while (my $row = <$fh>) {
  	chomp $row;
  	

  	if ($row =~ /<a href="([^"]+)" title="[^"]+">source<\/a>/) {
		if (exists $importhash{$1}) {

			} else {
				push @missingArray, $1;
			}
	}

}

close($fh);

print Dumper(\@missingArray);
print $counter;
print "\n";