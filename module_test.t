#!/usr/bin/perl -w

#
# File to test the insertion_module_test file
# 

use strict;

use Test;
use CGI::Test;        # exports ok ()
use Data::Dumper;     # useful to dump a data structure in order to inspect it


# Number of planned tests and number of the tests
#
BEGIN { plan tests => 6 }

# Loading our module
#
use insertion_module_test;

print "# I'm testing insertion_module_test.pm!\n";

# ------------------------------------------------------------------------------

print "\n# It should test the experiment_hurried, headers and read_files subs:\n";

experiment_hurried();

my $filename = "../output/experiment_module.sql";

ok(-e $filename);

my $ref_array = read_files ("../input/Mmusculus_NCBI_NR_2012-09_SEM_SHUF.txt");
my @array = @{$ref_array};
ok ($#array + 1 == 219680);

my $ref_headers = headers($ref_array);
my %hash = %{$ref_headers};
ok (scalar keys %hash == 26213);

# ------------------------------------------------------------------------------

print "\n# It should test the label_free sub:\n";
 
$ref_array = read_files ("../input/LabelFree_dNSAF.txt");
label_free($ref_array, $ref_headers);

ok (-e "../output/LabelFree_module.sql");

#-------------------------------------------------------------------------------

print "\n# It should test the evidences sub:\n";

$ref_array = read_files ("../input/evidenceNov2013.txt");
my ($ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide) = evidences($ref_array, "Nov13");
my %hash = %{$ref_sequence};
ok (scalar keys %hash == 295172);

#-------------------------------------------------------------------------------

print "\n# It should test the protein sub:\n";

$ref_array = read_files ("../input/proteinGroupsNov2013.txt");
protein($ref_array, $ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
$ref_contaminant_peptide, $ref_PEP_peptide, $ref_headers, "Nov13");

ok (-e "../output/SILAC_Nov13.sql");

#-------------------------------------------------------------------------------

print "\n# End of tests.\n\n";

system ("rm tmp/*");

exit 0;

