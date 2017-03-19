#!/usr/bin/perl -w

#
# File that calls insertion_module.pm
#
# It declares every scalar, array or hash used in this code in the beginning,
# calling the specified functions to populate CeTICSdb after that.
# Maybe "filter SILAC files" can be generalizated with a "for" command.
#

# Daniel F. Silva - 31/03/2015

# --------------------------------------------------------------------

# All scalar variables declared here are used to reference arrays and hashs
# from functions called; the first array is used to determine the experiment
# and the second one to determine the used file.

use strict;
use insertion_module_test;

my ($ref_lines, $ref_headers, $ref_sequence, $ref_fraction,
	$ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide, 
	$ref_contaminant_peptide, $ref_PEP_peptide);

my @exp_date = ('Nov13', 'Jun13', 'Nov12');

my @file_name = (
	'Mmusculus_NCBI_NR_2012-09_SEM_SHUF.txt',
	'LabelFree_dNSAF.txt',
	'evidenceNov2013.txt', 
	'proteinGroupsNov2013.txt', 
	'evidenceJun2013.txt', 
	'proteinGroupsJun2013.txt', 
	'evidenceNov2012.txt', 
	'proteinGroupsNov2012.txt'
	);

# --------------------------------------------------------------------

# Creates experiment IDs
experiment_hurried();

# --------------------------------------------------------------------

# filters NCBI headers
$ref_lines = read_files ("../input/$file_name[0]");
$ref_headers = headers($ref_lines);

# --------------------------------------------------------------------

# filters Label Free file
$ref_lines = read_files ("../input/$file_name[1]");
label_free($ref_lines, $ref_headers);

# --------------------------------------------------------------------

# filters SILAC Nov13 files
$ref_lines = read_files ("../input/$file_name[2]");
($ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide) = evidences($ref_lines, $exp_date[0]);

$ref_lines = read_files ("../input/$file_name[3]");
protein($ref_lines, $ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide, $ref_headers, $exp_date[0]);

# --------------------------------------------------------------------

# filters SILAC Jun13 files
$ref_lines = read_files ("../input/$file_name[4]");
($ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide) = evidences($ref_lines, $exp_date[1]);

$ref_lines = read_files ("../input/$file_name[5]");
protein($ref_lines, $ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide, $ref_headers, $exp_date[1]);

# --------------------------------------------------------------------

# filters SILAC Nov12 files
$ref_lines = read_files ("../input/$file_name[6]");
($ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide) = evidences($ref_lines, $exp_date[2]);

$ref_lines = read_files ("../input/$file_name[7]");
protein($ref_lines, $ref_sequence, $ref_fraction, $ref_experiment, $ref_ratio_peptide, $ref_reverse_peptide,
	 $ref_contaminant_peptide, $ref_PEP_peptide, $ref_headers, $exp_date[2]);

# --------------------------------------------------------------------

exit 0;

