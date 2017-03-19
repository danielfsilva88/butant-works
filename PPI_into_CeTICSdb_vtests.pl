#!/usr/bin/perl -w

#
# File that INSERT and UPDATE CeTICSdb with PPI_dbs
#

#
# Daniel F. Silva - 15/12/2015

# --------------------------------------------------------------------

use strict;
use Data::Dumper;
use DBI;

# ------------------------------------------------------------------------------

# Sub that reads files and save it in an array

sub read_files{
    
	my $file_path = $_[0];  # recieves file name as parameter
	open (ARQ, $file_path); # open file
	my @lines;
	while (<ARQ>){
	  chomp $_; 			# delete the linebreak from line read
	  push @lines, $_; 		# save in array the line read
	}
	close (ARQ); 			# close this file
	return (\@lines); 		# return the reference to array with the saved file
}

# -----------------------------------------------------------------------------

# UniProt hash

my $ref_UniProt = read_files ("../input/Fasta/blast/M_musculus_UniProt.fasta");
my @UniProt_data = @{$ref_UniProt};
my %UniProt;
my $id;

foreach my $field (0..$#UniProt_data){
	
	if ($UniProt_data[$field] =~ />sp\|(\w+)\|\S+\s(.*)\sOS.*/){
		
		$id = $1;
		$UniProt{$id}->{'description'} = $2;
		$UniProt{$id}->{'Y1'} = 'FALSE';
		$field++;
	} # closes if

	$UniProt{$id}->{'sequence'} .= $UniProt_data[$field];				# concatenate the sequence lines that contains AA from this protein ID
	
} # closes foreach UniProt

# ------------------------------------------------------------------------------

# NCBI hash

my $ref_NCBI = read_files ("../input/Fasta/NCBI/NCBI2UniProt.tab");
my @NCBI_data = @{$ref_NCBI};
my (@row, @values);
my %NCBI; # hash to correspond the Y1 proteins in CeTICSdb with NCBI-to-UniProt proteins

foreach my $field (1..$#NCBI_data){

	chomp $NCBI_data[$field]; # removes newline character
	@row = split ("\t", $NCBI_data[$field]); # split using spaces from line
	if ($row[3] eq "reviewed"){
	
		@values = split(',', $row[0]);
		$UniProt{$row[1]}->{'NCBI_acc'} = $values[0];
		$NCBI{$values[0]}->{'UP_acc'} = $row[1];
		if (! defined $UniProt{$row[1]}->{'description'}){
		
			$UniProt{$row[1]}->{'description'} = $row[4];
			$UniProt{$row[1]}->{'Y1'} = 'FALSE';
		} # UniProt description
	} # UniProt reviewed
} # close foreach

# ------------------------------------------------------------------------------

# STRING hash

my $ref_STRING = read_files ("../input/Fasta/STRINGdb/STRING2UniProt.tab");
my @STRING_data = @{$ref_STRING};

foreach my $field (1..$#STRING_data){

	chomp $STRING_data[$field]; # removes newline character
	@row = split ("\t", $STRING_data[$field]); # split using spaces from line

	if ($row[3] eq 'reviewed'){
	
		@values = split(',', $row[0]);
		$UniProt{$row[1]}->{'STRING_acc'} = $values[0];

		if (! defined $UniProt{$row[1]}->{'description'}){
		
			$UniProt{$row[1]}->{'description'} = $row[4];
		} # UniProt name
	} # UniProt reviewed
} # close foreach

# ------------------------------------------------------------------------------

# pensar num jeito melhor de fazer isso

my @STR_link_1 = ('xaa', 'xab', 'xac', 'xad', 'xae', 'xaf', 'xag',
				  'xah', 'xai', 'xaj', 'xak', 'xal', 'xam', 'xan',
				  'xao', 'xap', 'xaq', 'xar', 'xas', 'xat', 'xau');

# ------------------------------------------------------------------------------

# STRING combined_score

#my $ref_STRING_score = read_files ("../input/Fasta/STRINGdb/M_musculus_STRING_score.txt");

my %STRING;
my $last_file_line = 0;
#pensar num jeito melhor de fazer isso
foreach my $file (@STR_link_1){
	my $ref_STRING_score = read_files ("../input/Fasta/STRINGdb/$file");
	my @STRING_score_data = @{$ref_STRING_score};

	foreach my $field (1..$#STRING_score_data){

		chomp $STRING_score_data[$field]; # removes newline character
		@row = split (" ", $STRING_score_data[$field]); # split using spaces from line
		
		# taking all edges
		if ($row[2] > 799){
		
			$STRING{$last_file_line}->{'protein1'} = $row[0];
			$STRING{$last_file_line}->{'protein2'} = $row[1];
			$STRING{$last_file_line}->{'score'} = $row[2];
			$last_file_line += 1;
		}
		

	} # closes foreach STRING
	
} # closes foreach file loop

# ------------------------------------------------------------------------------

# depuration schema

#my $size = scalar(keys %UniProt);
#print "$size\n";
#print Dumper (\%UniProt);
#$size = scalar(keys %NCBI);
#print "\n\n\n$size\n";
#print Dumper (\%NCBI);
#$size = scalar(keys %STRING);
#print "\n\n\n$size\n";
#print Dumper (\%STRING);
#$size = scalar(keys %MySQL_id);
#print "$size\n";
#print Dumper (\%MySQL_id);
#exit 0;

# ------------------------------------------------------------------------------

# prepares to print PPI protein accessions table

open (PPI_protein, ">../output/PPI_protein_20151215.sql") or die "Error: could not open output file!\n";

my $count; 		 #MySQL id 
my $STR_acc;	 #STRING accession
my %MySQL_id;	 # hash to relating MySQL id to STRING accession

# ------------------------------------------------------------------------------

# calls DBI to UPDATE proteins that are already in db & print PPI accessions table


#my $dbh = DBI->connect
#   ("DBI:mysql:dbname=CeTICSdb", "root", "Butantan",
#	{ RaiseError => 0, AutoCommit => 1,  PrintError=>1});
   
#if(!$dbh){
#  exit 1;
#}
  

my $dbh = DBI->connect('DBI:mysql:cetics2', 'root', 'Butantan') or die "Couldn't connect to database: " . DBI->errstr;

my $sth = $dbh->prepare('SELECT id, protein_accession FROM protein ORDER BY id ASC') or die "Couldn't prepare statement: " . $dbh->errstr;
$sth->execute ();

while (my @tuple = $sth->fetchrow_array ()){

	$count = $tuple[0];
	my $gi_acc = $tuple[1];
#	print "\nid = $count & accession = $gi_acc\n";
	
	if (defined $NCBI{$gi_acc}){
	
#		print $NCBI{$gi_acc}->{'UP_acc'};

		my $UP_acc = $NCBI{$gi_acc}->{'UP_acc'};
		if (! defined $UniProt{$UP_acc}->{'STRING_acc'}){ $UniProt{$UP_acc}->{'STRING_acc'} = 'NULL'; }
		if (! defined $UniProt{$UP_acc}->{'sequence'})	{ $UniProt{$UP_acc}->{'sequence'} = 'NULL'; }

		print PPI_protein "UPDATE protein SET UniProt_accession = \"" . $UP_acc . "\", GenBank_accession = $gi_acc, STRING_accession = \"" . $UniProt{$UP_acc}->{'STRING_acc'}. "\", UniProt_sequence = \"" . $UniProt{$UP_acc}->{'sequence'} . "\" WHERE protein_accession = $gi_acc;\n";
		
		if ($UniProt{$UP_acc}->{'STRING_acc'} ne 'NULL'){
			$STR_acc = $UniProt{$UP_acc}->{'STRING_acc'}; # taking STRING accession code
			$MySQL_id{$STR_acc}->{'id'} = $count; 	# taking STRING accession MySQL id
		} # closes if
		
		$UniProt{$UP_acc}->{'Y1'} = 'TRUE';
		
	} # closes if NCBI_accession has its correspondent in Y1 db
} # closes $sth loop

$sth->finish ();
$dbh->disconnect or die "$DBI::errstr\n";

# ------------------------------------------------------------------------------

# depuration schema

#my $size = scalar(keys %MySQL_id);
#print "$size\n";
#print Dumper (\%MySQL_id);
#exit 0;

#my $size = scalar(keys %UniProt);
#print "$size\n";
#print Dumper (\%UniProt);
	
# ------------------------------------------------------------------------------

# executes the protein table printing
	
foreach my $acc (keys %UniProt){

	if (! defined $UniProt{$acc}->{'NCBI_acc'}){ $UniProt{$acc}->{'NCBI_acc'} = 'NULL'; }
	
	if ($UniProt{$acc}->{'Y1'} eq 'FALSE'){
		
		$count++; # $count saves the last sth $tuple[0], so it is need to plus 1 to the last id saved from now on to add in protein table bottom
		if (! defined $UniProt{$acc}->{'STRING_acc'}){ $UniProt{$acc}->{'STRING_acc'} = 'NULL'; }
		if (! defined $UniProt{$acc}->{'sequence'}){ $UniProt{$acc}->{'sequence'} = 'NULL'; }
		
		print PPI_protein "INSERT INTO protein (id, UniProt_accession, GenBank_accession, STRING_accession, description, UniProt_sequence) 
		VALUES ($count, '$acc', '$UniProt{$acc}->{'NCBI_acc'}', '$UniProt{$acc}->{'STRING_acc'}', \"" . $UniProt{$acc}->{'description'} . "\", \"" . $UniProt{$acc}->{'sequence'} . "\");\n";
	
		if ($UniProt{$acc}->{'STRING_acc'} ne 'NULL'){
			$STR_acc = $UniProt{$acc}->{'STRING_acc'}; # taking STRING accession code
			$MySQL_id{$STR_acc}->{'id'} = $count; 	# taking STRING accession MySQL id
		} # closes if to relate id-to-STRING_score
	} #closes if that print values not UPDATEd before
	
} # closes foreach print

close(PPI_protein);

# ------------------------------------------------------------------------------

# print PPI scores table

open (PPI_has_protein, ">../output/PPI_has_protein_20151216.sql") or die "Error: could not open output file!\n";

my ($protein1, $protein2, $id1, $id2);

foreach my $tuple (keys %STRING){

	$protein1 = $STRING{$tuple}->{'protein1'};	$protein2 = $STRING{$tuple}->{'protein2'}; # proteins accessions edge
	$id1 = $MySQL_id{$protein1}->{'id'}; 		$id2 = $MySQL_id{$protein2}->{'id'}; # take related proteins ids
	
	if (defined $id1 and $id2){ # if both ids are defined, there is a correspondence between UniProt and STRING
		
		print PPI_has_protein "INSERT INTO protein_has_protein (protein_id, protein_id1, STRING_score) 
		VALUES ($id1, $id2, $STRING{$tuple}->{'score'});\n";
		}
	
} # closes foreach print

close(PPI_has_protein);

# ------------------------------------------------------------------------------

exit 0;
