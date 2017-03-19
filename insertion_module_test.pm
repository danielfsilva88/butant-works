#!/usr/bin/perl.pl -w

#
# Module of insertion files
#

# This file adapts insertion files to a module file.

# Daniel F. Silva - 31/03/2015

# ------------------------------------------------------------------------------

use strict;
use Exporter;

our @ISA     = 'Exporter';
our @EXPORT  = qw(&read_files &headers &experiment_hurried &label_free &evidences &protein);

# ------------------------------------------------------------------

# Function that work only to read a file and save it in an array

sub read_files{
    
	my $file_path = $_[0];  # recieves the file name as a parameter
	open (ARQ, $file_path); # open that file
	my @lines;
	while (<ARQ>){
	  chomp $_; 			# delete the linebreak from line read
	  push @lines, $_; 		# save in array the line read
	}
	close (ARQ); 			# close this file
	return (\@lines); 		# return the reference to array with the saved file
}

#-------------------------------------------------------------------------------

sub headers{

	my %description; # hash to save headers
	my $ref_file = $_[0];
	my @array = @{$ref_file};
	
	foreach my  $field (0..$#array)
	{
		
		if ( ($array[$field] =~ />gi\|(\d+)\S+\s\S+\sFull=([^\;]+).*/) or ($array[$field] =~ /^>gi\|(\d+)\S+\s+(.*)/) ){ #SwissProt or NCBI, respectively
		
			$description{$1} = $2;
			$description{$1} =~ s/"/'/g;     # changes the quotes to avoid insertion errors
			$description{$1} =~ s/\n//g;    #  removes undesirable line breaks

		} # closes if
	} # closes foreach
	return \%description;
} # closes sub

#-------------------------------------------------------------------------------

sub experiment_hurried{

	# open file to be printed
	open (OUTPUT_EXPERIMENT, ">../output/experiment_module.sql") or die "Error: could not open output file!\n";

	# Start printing
	print OUTPUT_EXPERIMENT "USE CeTICSdb;\n";
	# print 0h Nov2013
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (1, 0, '', 'SILAC', 'GA', '0h  SILAC 2013-11-12 GA', '0h  SILAC GA 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (2, 0, '', 'SILAC', 'GB', '0h  SILAC 2013-11-12 GB', '0h  SILAC GB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (3, 0, '', 'SILAC', 'MB', '0h  SILAC 2013-11-12 MB', '0h  SILAC MB 2013-11-12', '2013-11-12');\n";
	# print 3h Nov2013 
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (4, 3, 'SFB', 'SILAC', 'GA', '3h SFB SILAC 2013-11-12 GA', '3h SFB SILAC GA 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (5, 3, 'SFB', 'SILAC', 'GB', '3h SFB SILAC 2013-11-12 GB', '3h SFB SILAC GB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (6, 3, 'SFB', 'SILAC', 'MB', '3h SFB SILAC 2013-11-12 MB', '3h SFB SILAC MB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (7, 3, 'FGF2', 'SILAC', 'GA', '3h FGF2 SILAC 2013-11-12 GA', '3h FGF2 SILAC GA 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (8, 3, 'FGF2', 'SILAC', 'GB', '3h FGF2 SILAC 2013-11-12 GB', '3h FGF2 SILAC GB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (9, 3, 'FGF2', 'SILAC', 'MB', '3h FGF2 SILAC 2013-11-12 MB', '3h FGF2 SILAC MB 2013-11-12', '2013-11-12');\n";
	# print 5h Nov2013
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (10, 5, 'SFB', 'SILAC', 'GA', '5h SFB SILAC 2013-11-12 GA', '5h SFB SILAC GA 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (11, 5, 'SFB', 'SILAC', 'GB', '5h SFB SILAC 2013-11-12 GB', '5h SFB SILAC GB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (12, 5, 'SFB', 'SILAC', 'MB', '5h SFB SILAC 2013-11-12 MB', '5h SFB SILAC MB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (13, 5, 'FGF2', 'SILAC', 'GA', '5h FGF2 SILAC 2013-11-12 GA', '5h FGF2 SILAC GA 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (14, 5, 'FGF2', 'SILAC', 'GB', '5h FGF2 SILAC 2013-11-12 GB', '5h FGF2 SILAC GB 2013-11-12', '2013-11-12');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (15, 5, 'FGF2', 'SILAC', 'MB', '5h FGF2 SILAC 2013-11-12 MB', '5h FGF2 SILAC MB 2013-11-12', '2013-11-12');\n";
	# print 0h Jun2013
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (16, 0, '', 'SILAC', 'GA', '0h  SILAC 2013-06-13 GA', '0h  SILAC GA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (17, 0, '', 'SILAC', 'GB', '0h  SILAC 2013-06-13 GB', '0h  SILAC GB 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (18, 0, '', 'SILAC', 'MA', '0h  SILAC 2013-06-13 MA', '0h  SILAC MA 2013-06-13', '2013-06-13');\n";
	# print 3h Jun2013
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (19, 3, 'SFB', 'SILAC', 'GA', '3h SFB SILAC 2013-06-13 GA', '3h SFB SILAC GA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (20, 3, 'SFB', 'SILAC', 'GB', '3h SFB SILAC 2013-06-13 GB', '3h SFB SILAC GB 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (21, 3, 'SFB', 'SILAC', 'MA', '3h SFB SILAC 2013-06-13 MA', '3h SFB SILAC MA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (22, 3, 'FGF2', 'SILAC', 'GA', '3h FGF2 SILAC 2013-06-13 GA', '3h FGF2 SILAC GA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (23, 3, 'FGF2', 'SILAC', 'GB', '3h FGF2 SILAC 2013-06-13 GB', '3h FGF2 SILAC GB 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (24, 3, 'FGF2', 'SILAC', 'MA', '3h FGF2 SILAC 2013-06-13 MA', '3h FGF2 SILAC MA 2013-06-13', '2013-06-13');\n";
	# print 5h Jun2013
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (25, 5, 'SFB', 'SILAC', 'GA', '5h SFB SILAC 2013-06-13 GA', '5h SFB SILAC GA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (26, 5, 'SFB', 'SILAC', 'GB', '5h SFB SILAC 2013-06-13 GB', '5h SFB SILAC GB 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (27, 5, 'SFB', 'SILAC', 'MA', '5h SFB SILAC 2013-06-13 MA', '5h SFB SILAC MA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (28, 5, 'FGF2', 'SILAC', 'GA', '5h FGF2 SILAC 2013-06-13 GA', '5h FGF2 SILAC GA 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (29, 5, 'FGF2', 'SILAC', 'GB', '5h FGF2 SILAC 2013-06-13 GB', '5h FGF2 SILAC GB 2013-06-13', '2013-06-13');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (30, 5, 'FGF2', 'SILAC', 'MA', '5h FGF2 SILAC 2013-06-13 MA', '5h FGF2 SILAC MA 2013-06-13', '2013-06-13');\n";
	# print Nov2012
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (31, 5, 'SFB', 'SILAC', 'MA', '5h SFB SILAC 2012-11-09 MA', '5h SFB SILAC MA 2012-11-09', '2012-11-09');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (32, 5, 'FGF2', 'SILAC', 'MA', '5h FGF2 SILAC 2012-11-09 MA', '5h FGF2 SILAC MA 2012-11-09', '2012-11-09');\n";
	# print 0h LF
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (33, 0, '', 'LF', 'GB', '0h  LF 2012-09-15 GB', '0h  LF GB 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (34, 0, '', 'LF', 'MA', '0h  LF 2012-09-15 MA', '0h  LF MA 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (35, 0, '', 'LF', 'MB', '0h  LF 2012-09-15 MB', '0h  LF MB 2012-09-15', '2012-09-15');\n";
	# print 3h LF
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (36, 3, 'SFB', 'LF', 'GB', '3h SFB LF 2012-09-15 GB', '3h SFB LF GB 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (37, 3, 'SFB', 'LF', 'MA', '3h SFB LF 2012-09-15 MA', '3h SFB LF MA 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (38, 3, 'SFB', 'LF', 'MB', '3h SFB LF 2012-09-15 MB', '3h SFB LF MB 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (39, 3, 'FGF2', 'LF', 'GB', '3h FGF2 LF 2012-09-15 GB', '3h FGF2 LF GB 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (40, 3, 'FGF2', 'LF', 'MA', '3h FGF2 LF 2012-09-15 MA', '3h FGF2 LF MA 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (41, 3, 'FGF2', 'LF', 'MB', '3h FGF2 LF 2012-09-15 MB', '3h FGF2 LF MB 2012-09-15', '2012-09-15');\n";
	# print 5h LF
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (42, 5, 'SFB', 'LF', 'GB', '5h SFB LF 2012-09-15 GB', '5h SFB LF GB 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (43, 5, 'SFB', 'LF', 'MA', '5h SFB LF 2012-09-15 MA', '5h SFB LF MA 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (44, 5, 'SFB', 'LF', 'MB', '5h SFB LF 2012-09-15 MB', '5h SFB LF MB 2012-09-15', '2012-09-15');\n";	
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (45, 5, 'FGF2', 'LF', 'GB', '5h FGF2 LF 2012-09-15 GB', '5h FGF2 LF GB 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (46, 5, 'FGF2', 'LF', 'MA', '5h FGF2 LF 2012-09-15 MA', '5h FGF2 LF MA 2012-09-15', '2012-09-15');\n";
	print OUTPUT_EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date) VALUES (47, 5, 'FGF2', 'LF', 'MB', '5h FGF2 LF 2012-09-15 MB', '5h FGF2 LF MB 2012-09-15', '2012-09-15');\n";

	# closes file that was printed
    close (OUTPUT_PROTEIN);
}

#-------------------------------------------------------------------------------

sub label_free{

	# open file to be printed
	open (OUTPUT_LF, ">../output/LabelFree_module.sql") or die "Error: could not open output file!\n";
	
	# starts printing
	print OUTPUT_LF "USE CeTICSdb;\n";

	my $ref_file = $_[0];
	my $description_ref = $_[1];
	my @array = @{$ref_file}; 		   # local variable to save the LF file
	my %description = %{$description_ref}; # descriptions hash from sub headers
	my $protein_group_id = 1;  # first value to protein_group.id in table
	my $protein_id = 1;        # first value to protein.id in table
	
	# maps the LF table file lines into the experiment ids in the database
	my %experiments = (
		           3 => 33, # 0h LF GB
		           4 => 34, # 0h LF MA
		           5 => 35, # 0h LF MB
		           # 6 average
		           7 => 36, # 3h SFB LF GB
		           8 => 37, # 3h SFB LF MA
		           9 => 38, # 3h SFB LF MB
		           # 10 average
		           11 => 39, # 3h FGF2 LF GB
		           12 => 40, # 3h FGF2 LF MA
		           13 => 41, # 3h FGF2 LF MB
		           # 14 average
		           15 => 42, # 5h SFB LF GB
		           16 => 43, # 5h SFB LF MA
		           17 => 44, # 5h SFB LF MB
		           # 18 average
		           19 => 45, # 5h FGF2 GB
		           20 => 46, # 5h FGF2 MA
		           21 => 47  # 5h FGF2 MB
		          );

	foreach my $field (1..$#array){

		my @tuple = split ("\t",  $array[$field]);
		my $accession = $tuple[0]; # column that have numerical ids
		$description{$accession} =~ s/\r//g;   # removes the next line character
		print OUTPUT_LF "INSERT INTO protein (protein_accession, id, description) VALUES ('$accession', $protein_id, \"" .  $description{$accession} . "\");\n";
		print OUTPUT_LF "INSERT INTO protein_group (id) VALUES ($protein_group_id);\n";
		print OUTPUT_LF "INSERT INTO protein_group_has_protein (protein_group_id, protein_id, protein_accession) VALUES ($protein_group_id, $protein_id, '$accession');\n";

		foreach my $experiment (sort {$a <=> $b} keys %experiments){
		
		  	my $ratio =  $tuple[$experiment];
		  	my $experiment_id = $experiments{$experiment};
			$ratio =~ s/,/./; # changes the comma to avoid insertion errors
			
			print OUTPUT_LF "INSERT INTO experiment_has_protein_group (experiment_id, protein_group_id, ratio_protein) VALUES ($experiment_id, $protein_group_id, $ratio);\n";
		} # closes foreach that deals with experiment hash
	  
	  	$protein_id++;
	  	$protein_group_id++;
	} # closes foreach to access lines
	
	# closes file that was printed
	close (OUTPUT_LF);
}

#-------------------------------------------------------------------------------

sub evidences{

	my $array_ref = $_[0];
	my @evidence_data = @{$array_ref};  # $_[0] stores the reference to the array that was passed as parameter of this sub
                                            # the command @{$array_ref} retrieves the array defined by the array reference $array_ref
	# hashes to save columns from evidence file
	my (%sequence, %fraction, %experiment, %ratio_peptide, 
		%reverse_peptide, %contaminant_peptide, %PEP_peptide);
	my $exp_date = $_[1]; # scalar that determines file date
	my $id_ev;			  # scalar that saves id from line read

	foreach my $field (1..$#evidence_data)
	{
		chomp $evidence_data[$field]; # $_ accesses @_ field
		my @line = split ("\t", $evidence_data[$field]); # saves each line field in array
		$id_ev = $line[53];
		$sequence{$id_ev} = $line[0];
		$fraction{$id_ev} = $line[16]; 
		$experiment{$id_ev} = $line[17]; 
		$ratio_peptide{$id_ev} = $line[46];
		$reverse_peptide{$id_ev} = $line[51];
		$contaminant_peptide{$id_ev} = $line[52];
		$PEP_peptide{$id_ev} = $line[39];
	
		if ($ratio_peptide{$id_ev} eq 'NaN') {$ratio_peptide{$id_ev} = 0;}
		foreach my $ij ($reverse_peptide{$id_ev}, $contaminant_peptide{$id_ev}){
			$ij eq '+' and $ij = 1 or $ij = 0;
		}
	
		# conditions to put automatically experiment_id
		if ($exp_date eq 'Nov13'){
			if    ($experiment{$id_ev} eq '0hga') {$experiment{$id_ev} = 1;}
			elsif ($experiment{$id_ev} eq '0hgb') {$experiment{$id_ev} = 2;}
			elsif ($experiment{$id_ev} eq '0hmb') {$experiment{$id_ev} = 3;}
			elsif ($experiment{$id_ev} eq '3hSga') {$experiment{$id_ev} = 4;}
			elsif ($experiment{$id_ev} eq '3hSgb') {$experiment{$id_ev} = 5;}
			elsif ($experiment{$id_ev} eq '3hSmb') {$experiment{$id_ev} = 6;}
			elsif ($experiment{$id_ev} eq '3hFga') {$experiment{$id_ev} = 7;}
			elsif ($experiment{$id_ev} eq '3hFgb') {$experiment{$id_ev} = 8;}
			elsif ($experiment{$id_ev} eq '3hFmb') {$experiment{$id_ev} = 9;}
			elsif ($experiment{$id_ev} eq '5hSga') {$experiment{$id_ev} = 10;}
			elsif ($experiment{$id_ev} eq '5hSgb') {$experiment{$id_ev} = 11;}
			elsif ($experiment{$id_ev} eq '5hSmb') {$experiment{$id_ev} = 12;}
			elsif ($experiment{$id_ev} eq '5hFga') {$experiment{$id_ev} = 13;}
			elsif ($experiment{$id_ev} eq '5hFgb') {$experiment{$id_ev} = 14;}
			elsif ($experiment{$id_ev} eq '5hFmb') {$experiment{$id_ev} = 15;}
		} # closes if Nov13
		elsif ($exp_date eq 'Jun13'){
			if    ($experiment{$id_ev} eq '0hGA') {$experiment{$id_ev} = 16;}
			elsif ($experiment{$id_ev} eq '0hGB') {$experiment{$id_ev} = 17;}
			elsif ($experiment{$id_ev} eq '0hMA') {$experiment{$id_ev} = 18;}
			elsif ($experiment{$id_ev} eq '3hFBSGA') {$experiment{$id_ev} = 19;}
			elsif ($experiment{$id_ev} eq '3hFBSGB') {$experiment{$id_ev} = 20;}
			elsif ($experiment{$id_ev} eq '3hFBSMA') {$experiment{$id_ev} = 21;}
			elsif ($experiment{$id_ev} eq '3hFGFGA') {$experiment{$id_ev} = 22;}
			elsif ($experiment{$id_ev} eq '3hFGFGB') {$experiment{$id_ev} = 23;}
			elsif ($experiment{$id_ev} eq '3hFGFMA') {$experiment{$id_ev} = 24;}
			elsif ($experiment{$id_ev} eq '5hFBSGA') {$experiment{$id_ev} = 25;}
			elsif ($experiment{$id_ev} eq '5hFBSGB') {$experiment{$id_ev} = 26;}
			elsif ($experiment{$id_ev} eq '5hFBSmb') {$experiment{$id_ev} = 27;}
			elsif ($experiment{$id_ev} eq '5hFGFGA') {$experiment{$id_ev} = 28;}
			elsif ($experiment{$id_ev} eq '5hFGFGB') {$experiment{$id_ev} = 29;}
			elsif ($experiment{$id_ev} eq '5hFGFMA') {$experiment{$id_ev} = 30;}
		} # closes elsif Jun13
		else {
			if    ($experiment{$id_ev} eq '5hFBS') {$experiment{$id_ev} = 31;}
			elsif ($experiment{$id_ev} eq '5hFGF') {$experiment{$id_ev} = 32;}
		} # closes else
	}

	return (\%sequence, \%fraction, \%experiment, \%ratio_peptide, 
	\%reverse_peptide, \%contaminant_peptide, \%PEP_peptide, $id_ev);
}

#-------------------------------------------------------------------------------

sub protein{

	my ($i, $l, $n, $p, $ev, $exp_id, $index); 
	my ($m, $rat, $end) = (0, 0, 0);
	my ($proteinGroup_id, $protein_id, $peptide_id); # id counters; 
	my (%ratio_intensity, %ratio_expid);

	my $array_ref = $_[0];
	my $sequence_ref = $_[1];
	my $fraction_ref = $_[2];
	my $experiment_ref = $_[3];
	my $ratio_peptide_ref = $_[4];
	my $reverse_peptide_ref = $_[5];
	my $contaminant_peptide_ref = $_[6];
	my $PEP_peptide_ref = $_[7];
	my $description_ref = $_[8];
	my $exp_date = $_[9];
	my @tuple1 = @{$array_ref};
	my %sequence = %{$sequence_ref};
	my %fraction = %{$fraction_ref};
	my %experiment = %{$experiment_ref};
	my %ratio_peptide = %{$ratio_peptide_ref};
	my %reverse_peptide = %{$reverse_peptide_ref};
	my %contaminant_peptide = %{$contaminant_peptide_ref};
	my %PEP_peptide = %{$PEP_peptide_ref};
	my %description = %{$description_ref};
	my @prim = split ("\t", "$tuple1[0]"); # saves each line field in array


    open (OUTPUT_PROTEIN, ">../output/SILAC_$exp_date.sql") or die "Error: could not open output file!\n";
 
	# index to desired fields in MaxQuant output first row
	for ($i = 0; $prim[$i] ne "Only identified by site"; $i++){ # Oibs counter
	}
	my ($j, $k) = ($i + 1, $i + 2); # Reverse & contaminant counter
	for ($l=0; $prim[$l] ne "PEP"; $l++){ # PEP counter
	}
	until ($prim[$m] =~ /Intensity\sL\s\dh\w*/){ # Intensity L counter
		$m++;
	}
	until ($prim[$rat] =~ /Ratio\s+H\/L\s+normalized\s+(\d)h\w*/){ # 'First useful ratio' counter of MaxQuant output - already generalizated
		$rat++;
	}
	until ($prim[$end] =~ /Sequence\s+coverage\s+\dh/){ # First column after ratios
		$end++;
	}
	for ($ev=0; $prim[$ev] ne "Evidence IDs"; $ev++){ # Evidence counter
	}
	if    ($exp_date eq 'Nov13') {$exp_id = 1; $proteinGroup_id = 2967; $protein_id = 2967; $peptide_id = 0;    }
	elsif ($exp_date eq 'Jun13') {$exp_id = 16; $proteinGroup_id = 5202; $protein_id = 6428; $peptide_id = 19154;}
	elsif ($exp_date eq 'Nov12') {$exp_id = 31; $proteinGroup_id = 6339; $protein_id = 8332; $peptide_id = 26059;}
	
	for ($p = 0; ($rat + 4*$p) < $end; $p++){ # fills hashes that take account by ratios, intensities & experiment ids 
		$index = $rat + 4*$p;
		$ratio_intensity{$index} = ($m + 3*$p);
		$ratio_expid{$index} = $exp_id;
		$exp_id++;
	}
	print OUTPUT_PROTEIN "USE CeTICSdb;\n";
	
	foreach my $indexA (1..$#tuple1){	

		my @tuple = split ("\t", "$tuple1[$indexA]"); # saves each line field in array

		# boolean conditions 'Oibs', 'Reverse' and 'Contaminant': True (1) or False (0)
		foreach my $ijk ($i, $j, $k)
		{
			$tuple[$ijk] eq '+' and $tuple[$ijk] = 1 or $tuple[$ijk] = 0;
		}
	
		# 'protein_group', 'protein' and 'protein_group_has_protein' insertions
		print OUTPUT_PROTEIN "INSERT INTO protein_group (id, only_identified_by_site, reverse, contaminant, PEP) VALUES ($proteinGroup_id, $tuple[$i], $tuple[$j], $tuple[$k], $tuple[$l]);\n";

		my $accession_field = $tuple[0]; # saves in array the first column - all proteinIDs
		$accession_field =~ s/gi\|//g;   # left just a numerical id
		my @accessions = split (";", $accession_field); # saves single proteinID in an array, if $accession_field has more than one
		
		foreach my $indexP (0..$#accessions){
		
			if ( ($tuple[$i] == 1) or ($accessions[$indexP] =~ /CON/) or ($accessions[$indexP] =~ /REV/) ){ # condition to fill Oibs, Rev and Con descriptions
		
				$description{$accessions[$indexP]} = "FALSE POSITIVE";
			}
		
			$description{$accessions[$indexP]} =~ s/\r//g;   # removes the next line character
			$description{$accessions[$indexP]} =~ s/\n//g;  # to avoid printing and mysql
			$description{$accessions[$indexP]} =~ s/\@//g; # problems
		
			print OUTPUT_PROTEIN "INSERT INTO protein (protein_accession, id, description) VALUES ('$accessions[$indexP]', $protein_id, \"" .  $description{$accessions[$indexP]} . "\");\n";
			print OUTPUT_PROTEIN "INSERT INTO protein_group_has_protein (protein_group_id, protein_id, representative_protein_accession, protein_accession) VALUES ($proteinGroup_id, $protein_id, '$accessions[0]', '$accessions[$indexP]');\n";
			$protein_id++;
		} #foreach accessions
	
		my @evidences = split (";", $tuple[$ev]); # saves single Evidence ID in an array, if $evidence_field has more than one
		my $representative_evidence = $evidences[0]; # auxiliar variable that saves first Evidence_ID
	
		foreach my $indexE (0..$#evidences){ #works in every Evidence_ID splitted before
		
			if ( ($sequence_ref->{$evidences[$indexE]} ne $sequence_ref->{$representative_evidence}) or ($indexE == 0) ){ # condition to fill Peptide table, comparing the actual Evidence_ID sequence with its antecessor to see if they are the same
		
				$peptide_id++;
				print OUTPUT_PROTEIN "INSERT INTO peptide (id, sequence, reverse, contaminant, PEP) VALUES ($peptide_id, \"" .  $sequence{$evidences[$indexE]} . "\", \"" .  $reverse_peptide{$evidences[$indexE]} . "\", \"" .  $contaminant_peptide{$evidences[$indexE]} . "\", \"" .  $PEP_peptide{$evidences[$indexE]} . "\");\n";

				print OUTPUT_PROTEIN "INSERT INTO protein_group_has_peptide (protein_group_id, peptide_id) VALUES ($proteinGroup_id, $peptide_id);\n";
				$representative_evidence = $evidences[$indexE]; # saves actual Evidence_ID in auxiliar variable
			}
		
			print OUTPUT_PROTEIN "INSERT INTO peptide_has_experiment (peptide_id, experiment_id, evidence_id, fraction, ratio_peptides, description) VALUES ($peptide_id, $experiment{$evidences[$indexE]}, $evidences[$indexE], \"" .  $fraction{$evidences[$indexE]} . "\", \"" .  $ratio_peptide{$evidences[$indexE]} . "\", '$exp_date');\n";

		} # foreach evidences
	
		# 'experiment_has_protein_group' insertion 
		foreach my $indexEPg (sort {$a <=> $b} keys %ratio_intensity){
			if ($tuple[$indexEPg] eq 'NaN') {$tuple[$indexEPg] = 0;} #ratio_peptide can be NaN, "" or a number
			$exp_id = $ratio_expid{$indexEPg};
			$m = $ratio_intensity{$indexEPg};
			$n = $m + 1;
			print OUTPUT_PROTEIN "INSERT INTO experiment_has_protein_group (experiment_id, protein_group_id, light_intensity, heavy_intensity, ratio_protein, description) VALUES ($exp_id, $proteinGroup_id, $tuple[$m], $tuple[$n], $tuple[$indexEPg], '$exp_date');\n";
		
		} # foreach from experiment_has_protein_group
	
		$proteinGroup_id++;

	} # foreach $indexA

        close (OUTPUT_PROTEIN);

	return;

} # sub protein


