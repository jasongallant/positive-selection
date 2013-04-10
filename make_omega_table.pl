#!/usr/bin/perl

use strict;
use warnings;
use Bio::SearchIO; 
use Bio::DB::Fasta;


open (INFILE,'<', '../step4_ortholog_tables/cluster_noduplicate_proteins.txt') or die $!;

while (my $line =<INFILE>) {
    next if ($line =~ m/gene_ID/);
    my ($genename,$clustername,$eelid,$danioid,$codid,$fuguid,$medakaid,$platyid,$stickleid,$tetrodadonid,$tilapiaid,$xenopusid) = split "\t", $line;
    chomp($genename,$clustername,$eelid,$danioid,$codid,$fuguid,$medakaid,$platyid,$stickleid,$tetrodadonid,$tilapiaid,$xenopusid);
    $genename =~ s/:/_/;
    my $inputname=("../step8_paml/".$genename."_pamlresults.txt");
    print $inputname, "\n";
    next unless (-e $inputname);
    open (GENEFILE, '<',$inputname) or die $!;
    while (my $line2 =<GENEFILE>){
        my($global_df,$global_omega,$global_kappa,$global_lnL,$branch_df,$branch_omega_0,$branch_omega_1,$branch_kappa,$branch_lnL,$null_df,$null_omega_0,$null_omega_1,$null_kappa,$null_lnL,$teststat_for_eel,$testdf_for_eel,$teststat_for_pos,$testdf_for_pos)=split"\t",$line2;


        my $outputname="../step9_paml/eel_consolidated_pamlresults.txt";
        open (OUTFILE, '>>', $outputname) or die $!;
        print OUTFILE $genename, "\t";
        print OUTFILE $clustername,"\t";
        print OUTFILE $eelid, "\t";
        print OUTFILE $global_df,"\t";
        print OUTFILE $global_omega,"\t";
        print OUTFILE $global_kappa,"\t";
        print OUTFILE $global_lnL,"\t";
        print OUTFILE $branch_df,"\t";
        print OUTFILE $branch_omega_0,"\t";
        print OUTFILE $branch_omega_1,"\t";
        print OUTFILE $branch_kappa,"\t";
        print OUTFILE $branch_lnL,"\t";
        print OUTFILE $null_df,"\t";
        print OUTFILE $null_omega_0,"\t";
        print OUTFILE $null_omega_1,"\t";
        print OUTFILE $null_kappa,"\t";
        print OUTFILE $null_lnL,"\t";
        print OUTFILE $teststat_for_eel,"\t";
        print OUTFILE $testdf_for_eel,"\t";
        print OUTFILE $teststat_for_pos,"\t";
        print OUTFILE $testdf_for_pos, "\n";
    }
}




