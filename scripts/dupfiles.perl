#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $directory = '_posts';
my @fileNameArray;
my %sourceLinkHash;
my %duplicatesHash;

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

		if ($row =~ /^\[Source\].+/) {
			$sourceLink = $row;
			$numLinksInFile++;
			if ($numLinksInFile > 1) {
				print "$file has more than one link in body\n";
			}
			$numTotal = $numTotal + 1;
			$filesProccessedHash{$file} = undef;
		}

		if ($row =~ /^\s*---\s*$/) {
			$metaStatus = 0;
		} elsif ($row =~ /^title:\s(.+)/) {
			$articleTitle = $1;
		}
		

		

	}

	if (defined $sourceLink) {
		if (exists $sourceLinkHash{$sourceLink}) {
			#print " -- Linked Article Already Exists!\n";
			$numDuplicate++;
			my %existingFileHash = %{$sourceLinkHash{$sourceLink}};
			my %newFileHash;

			if (defined $articleTitle) {
				$newFileHash{'title'} = $articleTitle;
			} else {
				$newFileHash{'title'} = undef;
			}

			$existingFileHash{$file} = {%newFileHash};

			#my @articleArray;
			#push @articleArray, $file;

			$sourceLinkHash{$sourceLink} = {%existingFileHash};
			#print "$sourceLink\n" ;

			$duplicatesHash{$sourceLink} = {%existingFileHash};
		} else {
			$numUnique++;
			#print "\n";

			my %fileHash;

			if (defined $articleTitle) {
				$fileHash{'title'} = $articleTitle;
			} else {
				$fileHash{'title'} = undef;
			}



			#my @articleArray;
			#push @articleArray, $file;

			$sourceLinkHash{$sourceLink}{$file} = {%fileHash};
			#print "$sourceLink\n" ;
		}

		
	} else {
		print "no source link found!!! for articl: $filename\n";
	}

	


	close $fh;
}

print scalar keys %filesProccessedHash;
print "\n";

foreach my $temp (@fileNameArray) {
	if (exists $filesProccessedHash{$temp}) {

		} else {
			print "$temp not in process queue\n";
		}
}



print "total number of files with links in text: $numTotal\n";
print "number of files without duplicates: $numUnique\n";
print "number of duplicate files: $numDuplicate\n";

#print "file names\n";
#print Dumper(\@fileNameArray);

#print "Hash of Links:\n";
#print Dumper(\%sourceLinkHash);

#print "Number of links with duplicate articles: ";
#print scalar keys %duplicatesHash;
#print "\n";

#print "Hash of duplicate articles:\n";
#print Dumper(\%duplicatesHash);


my $maxNumFiles = 0;
my $minNumFiles = undef;

foreach my $key (keys %duplicatesHash) {
	my %fileHash = %{$duplicatesHash{$key}};
	my $numKeys = scalar keys %fileHash;

	if ($numKeys > $maxNumFiles) {
		$maxNumFiles = $numKeys;
	}
	if (! defined $minNumFiles || $numKeys < $minNumFiles) {
		$minNumFiles = $numKeys;
	}
}

if (!defined $minNumFiles) {
	$minNumFiles = $maxNumFiles;
}
print "Max number of articles for one link: $maxNumFiles\n";
print "Min number of articles for one link: $minNumFiles\n";
$maxNumFiles = 0;

my $needsExtra = 0;
my $numDupFiles = 0;
my $zeroCandidates = 0;
my @fileNamesToDelete;
my @fileNamesToKeep;

my %filesKeptDeleted;

foreach my $key (keys %duplicatesHash) {
	my %fileHash = %{$duplicatesHash{$key}};
	
	my @candidatesArray;
	my $titleLength = 0;
	foreach my $fileHashKey (keys %fileHash) {

		#print "filename for $key: $fileHashKey\n";
		if ($fileHashKey !~ /\d+-\d+-\d+-\d+-/) {
			#print "$fileHashKey\n";
			my $title = $fileHash{$fileHashKey}{'title'};
			print "$fileHashKey\n" if (! defined $title);
			print Dumper(\$fileHash{$fileHashKey}) if (! defined $title);

			#print "$title\n";
			if ($title !~ /_/) {
				if (length $title > $titleLength) {
					if (defined $candidatesArray[0]) {
						my $filename = join "", $directory, "/", $fileHashKey;
						push @fileNamesToDelete, $filename;
						$filesKeptDeleted{$key}{'deleted'} = $candidatesArray[0];
					}
					$titleLength = length $title;
					$candidatesArray[0] =  $fileHashKey;
					
				} else {
					my $filename = join "", $directory, "/", $fileHashKey;
					push @fileNamesToDelete, $filename;
					$filesKeptDeleted{$key}{'deleted'} = $fileHashKey;
				}
				
			} else {
				my $filename = join "", $directory, "/", $fileHashKey;
				push @fileNamesToDelete, $filename;
				$filesKeptDeleted{$key}{'deleted'} = $fileHashKey;
			}

			
		} else {
			$filesKeptDeleted{$key}{'deleted'} = $fileHashKey;
			my $filename = join "", $directory, "/", $fileHashKey;
			push @fileNamesToDelete, $filename;
		}


	}

	push @fileNamesToKeep, $candidatesArray[0];
	$filesKeptDeleted{$key}{'kept'} = $candidatesArray[0];

	if (scalar @candidatesArray == 0) {
		$zeroCandidates = 1;
		#print "filename $key has zero candidates\n";
		#print Dumper(\%fileHash);
	} elsif (scalar @candidatesArray == 2) {
		$needsExtra = 1;
		$numDupFiles = $numDupFiles + 1;
		#sprint "filename $key has two candidates\n";
		#print Dumper(\%fileHash);
	}
}

print "One of the links has zero candidates\n" if $zeroCandidates;
print "Needs an extra level of scrutiny\n" if $needsExtra;
print "$numDupFiles duplicate files remaining\n";

if (scalar @fileNamesToKeep == scalar @fileNamesToDelete) {
	print "Duplicate sorting successfull, number of files to delete is same as number of files to keep\n";
} else {
	print scalar @fileNamesToKeep;
	print "\n";
	print scalar @fileNamesToDelete;
	print "\n";
	print "Files to keep:\n";
	
	print Dumper(\@fileNamesToKeep);
	print "Files to delete:\n";
	
	print Dumper(\@fileNamesToDelete);
}

print "Number of files to be deleted: ";
print scalar keys @fileNamesToDelete;
print "\n";

print "hash showing deleted and kept keys:\n";

print Dumper(\%filesKeptDeleted);

unlink @fileNamesToDelete;

print "Original number of files: ";
print scalar @fileNameArray;
print "\nNumber of files deleted: ";
print scalar keys @fileNamesToDelete;
print "\nNumber of files without duplicate links: ";
print (scalar keys %sourceLinkHash);
print "\n";
