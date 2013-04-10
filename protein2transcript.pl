#!/usr/bin/perl

use strict;
use warnings;

open (DANIOFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/danio_protein_transcript_mart_export.txt') or die $!;
open (CODFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/cod_protein_transcript_mart_export.txt') or die $!;
open (FUGUFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/fugu_protein_transcript_mart_export.txt') or die $!;
open (MEDAKAFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/medaka_protein_transcript_mart_export.txt') or die $!;
open (PLATYFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/platy_protein_transcript_mart_export.txt') or die $!;
open (STICKLEFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/stickle_protein_transcript_mart_export.txt') or die $!;
open (TETFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/tetrodadon_protein_transcript_mart_export.txt') or die $!;
open (TILAPIAFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/tilapia_protein_transcript_mart_export.txt') or die $!;
open (XENOPUSFILE,'<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/resources/ensembl_translation_tables/xenopus_protein_transcript_mart_export.txt') or die $!;

my %danio_hits;
while (my $line =<DANIOFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $danio_hits{$id1} = $id2;
}
my %cod_hits;
while (my $line =<CODFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $cod_hits{$id1} = $id2;
}
my %fugu_hits;
while (my $line =<FUGUFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $fugu_hits{$id1} = $id2;
}
my %medaka_hits;
while (my $line =<MEDAKAFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $medaka_hits{$id1} = $id2;
}
my %platy_hits;
while (my $line = <PLATYFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $platy_hits{$id1} = $id2;
}
my %stickle_hits;
while (my $line = <STICKLEFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $stickle_hits{$id1} = $id2;
}
my %tetrodadon_hits;
while (my $line =<TETFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $tetrodadon_hits{$id1} = $id2;
}
my %tilapia_hits;
while (my $line =<TILAPIAFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $tilapia_hits{$id1} = $id2;
}
my %xenopus_hits;
while (my $line = <XENOPUSFILE>) {
    $line =~ s/\R//g;
    my ($id1,$id2) = split "\t", $line;
    $xenopus_hits{$id1} = $id2;
}
print "gene_name\tcluster\tgene_ID\tdanio_protein\tcod_protein\tfugu_protein\tmedaka_protein\tplaty_protein\tstickle_protein\ttetrodadon_protein\ttilapia_protein\txenopus_protein\n";
open (PROTEINFILE, '<', '/Volumes/Data/jasongallant/Desktop/eel_positive_selection/step4_ortholog_tables/cluster_noduplicate_proteins.txt') or die $!;
while (my $line = <PROTEINFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,$id6,$id7,$id8,$id9,$id10,$id11,$id12) = split "\t", $line;
	chomp($id1,$id2,$id3,$id4,$id5,$id6,$id7,$id8,$id9,$id10,$id11,$id12);
    #print $xenopus_hits{$id12};
    next if ($line =~ m/gene_ID/);
	next if ($id2=~/^\s*$/);
    print  "$id1\t$id2\t$id3\t$danio_hits{$id4}\t$cod_hits{$id5}\t$fugu_hits{$id6}\t$medaka_hits{$id7}\t$platy_hits{$id8}\t$stickle_hits{$id9}\t$tetrodadon_hits{$id10}\t$tilapia_hits{$id11}\t$xenopus_hits{$id12}\n";
}