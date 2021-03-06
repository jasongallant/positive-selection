#!/usr/bin/perl

use strict;
use warnings;
use Bio::SearchIO; 
use Bio::DB::Fasta;


open (INFILE,'<', '../step4_ortholog_tables/cluster_noduplicate_proteins.txt') or die $!;

my $eelfile = "../resources/proteins/eel_pep.fasta";
my $daniofile="../resources/proteins/danio_pep.fasta";
my $codfile = "../resources/proteins/cod_pep.fasta";
my $fugufile = "../resources/proteins/fugu_pep.fasta";
my $medakafile= "../resources/proteins/medaka_pep.fasta";
my $platyfile = "../resources/proteins/platy_pep.fasta";
my $sticklefile = "../resources/proteins/stickle_pep.fasta";
my $tetrodadonfile = "../resources/proteins/tetraodon_pep.fasta";
my $tilapiafile = "../resources/proteins/tilapia_pep.fasta";
my $xenopusfile="../resources/proteins/xenopus_pep.fasta";

my $eeldb = Bio::DB::Fasta->new($eelfile);
my $daniodb = Bio::DB::Fasta->new($daniofile);
my $coddb = Bio::DB::Fasta->new($codfile);
my $fugudb = Bio::DB::Fasta->new($fugufile);
my $medakadb =Bio::DB::Fasta->new($medakafile);
my $platydb =Bio::DB::Fasta->new($platyfile);
my $stickledb=Bio::DB::Fasta->new($sticklefile);
my $tetrodadondb=Bio::DB::Fasta->new($tetrodadonfile);
my $tilapiadb=Bio::DB::Fasta->new($tilapiafile);
my $xenopusdb=Bio::DB::Fasta->new($xenopusfile);

while (my $line =<INFILE>) {
    next if ($line =~ m/gene_ID/);
    #next if ($id2=~/^\s*$/);
    my ($genename,$clustername,$eelid,$danioid,$codid,$fuguid,$medakaid,$platyid,$stickleid,$tetrodadonid,$tilapiaid,$xenopusid) = split "\t", $line;
    chomp($genename,$clustername,$eelid,$danioid,$codid,$fuguid,$medakaid,$platyid,$stickleid,$tetrodadonid,$tilapiaid,$xenopusid);
    $eelid="$eelid.t1";
    my $eelseq = $eeldb->seq($eelid);
    my $danioseq = $daniodb->seq($danioid);
    my $codseq = $coddb->seq($codid);
    my $fuguseq = $fugudb->seq($fuguid);
    my $medakaseq=$medakadb->seq($medakaid);
    my $platyseq=$platydb->seq($platyid);
    my $stickleseq=$stickledb->seq($stickleid);
    my $tetrodadonseq=$tetrodadondb->seq($tetrodadonid);
    my $tilapiaseq=$tilapiadb->seq($tilapiaid);
    my $xenopusseq=$xenopusdb->seq($xenopusid);


my $outputname="$genename.fasta";
$outputname =~ s/:/_/;

open (GENEFILE, '>', $outputname) or die $!;
print GENEFILE ">Electrophorus_electricus\n";
print GENEFILE $eelseq,"\n"; 
print GENEFILE ">Danio_rerio\n";
print GENEFILE $danioseq,"\n";
print GENEFILE ">Gadus_morhua\n";
print GENEFILE $codseq,"\n";
print GENEFILE ">Takifugu_rubripes\n";
print GENEFILE $fuguseq,"\n";
print GENEFILE ">Oryzias_latipes\n";
print GENEFILE $medakaseq,"\n";
print GENEFILE ">Xiphophorus_maculatus\n";
print GENEFILE $platyseq,"\n";
print GENEFILE ">Gasterosteus_aculeatus\n";
print GENEFILE $platyseq,"\n";
print GENEFILE ">Tetraodon_nigroviridis\n";
print GENEFILE $tetrodadonseq,"\n";
print GENEFILE ">Oreochromis_niloticus\n";
print GENEFILE $tilapiaseq,"\n";
print GENEFILE ">Xenopus_tropicalis\n";
print GENEFILE $xenopusseq,"\n";
}





