#!/usr/bin/perl.pl -w

#
# Final module of insertion Y1 protein and peptide files from SILAC and Label
# Free to MySQL CeTICsdb database. 
#
# Daniel F. Silva - 19/10/2015

# ------------------------------------------------------------------------------

use strict;
use Exporter;

our @ISA     = 'Exporter';
our @EXPORT  = qw(&read_files &headers &experiment_hurried &label_free &evidences &protein);

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

#-------------------------------------------------------------------------------

# Sub that takes the description of some proteinID from the NCBI database
# Mmusculus_NCBI_NR_2012-09_SEM_SHUF

sub headers{

	my %description; # hash to save headers
	my $ref_file = $_[0];
	my @array = @{$ref_file};
	
	foreach my  $field (0..$#array)
	{
		
		#SwissProt or NCBI, respectively
		if ( 
		($array[$field] =~ />gi\|(\d+)\S+\s\S+\sFull=([^\;]+).*/) or 
		($array[$field] =~ /^>gi\|(\d+)\S+\s+(.*)/) )
		{ 
		
			$description{$1} = $2;
			$description{$1} =~ s/"/'/g;     # changes the quotes to avoid insertion errors
			$description{$1} =~ s/\n//g;     # removes undesirable line breaks

		} # closes if
	} # closes foreach
	return \%description;
} # closes sub

#-------------------------------------------------------------------------------

sub experiment{

	# open file to be printed
	open (EXPERIMENT, ">../output/experiment_insertion.sql") or die "Error: could not open output file!\n";

	# ids: 1 - 47
	# time: 0, 3, 5
	# factor: '', SFB, FGF
	# quantification_method: SILAC, LF
	# replication_number: GA, GB, MA, MB
	# name: 5h SFB SILAC 2013-11-12 GA, i.e., time factor quant_meth prod_date rep_number
	# description: 5h SFB SILAC 2013-11-12 GA (same as name)
	# production_data: 2013-11-12, 2013-06-13, 2012-11-09, 2012-09-15
	# project_id: 0
	
	# Start printing (tentar fazer esta sub com um hash e um for)
	print EXPERIMENT "USE CeTICSdb;\n";
	# print 5h Nov2013
	print EXPERIMENT "INSERT INTO experiment (id, time, factor, quantification_method, replication_number, name, description, production_date, project_id) VALUES (1, 5, 'SFB', 'SILAC', 'GA', '5h SFB SILAC 2013-11-12 GA', '5h SFB SILAC GA 2013-11-12', '2013-11-12', 0);\n";


