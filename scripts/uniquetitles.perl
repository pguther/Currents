#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $directory = '_posts';
my @fileNameArray;
my %sourceLinkHash;
my %duplicatesHash;

my %titleHash;
my %dupTitleHash;

my $numUnique = 0;
my $numDuplicate = 0;
my $numTotal = 0;

my %filesProccessedHash;


opendir (DIR, $directory) or die $1;

while (my $file = readdir(DIR)) {
	next if ($file =~ m/^\./);
	push @fileNameArray, $file;
	#print "$file\n";
}

closedir(DIR);

foreach my $file (@fileNameArray) {
	#print "$file";
	my $filename = join "", $directory, "/", $file;

	#print "name with path: $filename\n";

	open (my $fh, $filename) or die "Could not open file: $file: $!";
	my $sourceLink;
	my $metaStatus = 0;
	my $articleTitle;
	my $numLinksInFile = 0;
	while (my $row = <$fh>) {
		chomp $row;

		if ($row =~ /^title:\s(.+)/) {
			$articleTitle = $1;
		}

	}

	if (defined $articleTitle) {

		} else {
			print "$file has no article title\n";
		}

	if (exists $titleHash{$articleTitle}) {
		my @titleHashFiles = $titleHash{$articleTitle};
		$titleHashFiles[scalar @titleHashFiles] = $file;
		$titleHash{$articleTitle} = \@titleHashFiles;
		$dupTitleHash{$articleTitle} = \@titleHashFiles;
	} else {
		my @titleHashFiles;
		$titleHashFiles[0] = $file;
		$titleHash{$articleTitle} = \@titleHashFiles;
	}

	
	close $fh;
}

print "files with duplicate titles:\n";
print Dumper(\%dupTitleHash);

print "Num files: ";
print scalar @fileNameArray;
print "\nNum Unique titles: ";
print scalar keys %titleHash;
print "\n";