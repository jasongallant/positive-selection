#!/usr/bin/perl

use strict;
use warnings;

open (CODFILE,'<', '/Volumes/Data/jasongallant/Downloads/cod_mart_export_one2one_final.txt') or die $!;
open (FUGUFILE,'<', '/Volumes/Data/jasongallant/Downloads/fugu_mart_export_one2one_final.txt') or die $!;
open (MEDAKAFILE,'<', '/Volumes/Data/jasongallant/Downloads/medaka_mart_export_one2one_final.txt') or die $!;
open (PLATYFILE,'<', '/Volumes/Data/jasongallant/Downloads/platy_mart_export_one2one_final.txt') or die $!;
open (STICKLEFILE,'<', '/Volumes/Data/jasongallant/Downloads/stickle_mart_export_one2one_final.txt') or die $!;
open (TETFILE,'<', '/Volumes/Data/jasongallant/Downloads/tetrodadon_mart_export_one2one_final.txt') or die $!;
open (TILAPIAFILE,'<', '/Volumes/Data/jasongallant/Downloads/tilapia_mart_export_one2one_final.txt') or die $!;
open (XENOPUSFILE,'<', '/Volumes/Data/jasongallant/Downloads/xenopus_mart_export_one2one_final.txt') or die $!;

my %cod_hits;
while (my $line =<CODFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $cod_hits{$id3} = $id4;
}
my %fugu_hits;
while (my $line =<FUGUFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $fugu_hits{$id3} = $id4;
}
my %medaka_hits;
while (my $line =<MEDAKAFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $medaka_hits{$id3} = $id4;
}
my %platy_hits;
while (my $line = <PLATYFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $platy_hits{$id3} = $id4;
}
my %stickle_hits;
while (my $line = <STICKLEFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $stickle_hits{$id3} = $id4;
}
my %tetrodadon_hits;
while (my $line =<TETFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $tetrodadon_hits{$id3} = $id4;
}
my %tilapia_hits;
while (my $line =<TILAPIAFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $tilapia_hits{$id3} = $id4;
}
my %xenopus_hits;
while (my $line = <XENOPUSFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,@other) = split "\t", $line;
    $xenopus_hits{$id3} = $id4;
}
print "gene_name\tcluster\tgene_ID\tdanio_protein\tcod_protein\tfugu_protein\tmedaka_protein\tplaty_protein\tstickle_protein\ttetrodadon_protein\ttilapia_protein\txenopus_protein\n";
open (EXPRESSFILE, '<', '/Volumes/Data/jasongallant/Desktop/gene_expression_20130211_withtrans.txt') or die $!;
while (my $line = <EXPRESSFILE>) {
    my ($id1,$id2,$id3,$id4,$id5,$id6,$id7,$id8,$id9,$id10,@other) = split "\t", $line;
	next if ($line =~ m/gene_ID/);
	next if ($id2=~/^\s*$/);
    print  "$id4 \t $id7 \t $id1 \t $id3 \t";
    if (defined $cod_hits{$id2}){
		 print "$cod_hits{$id2} \t"; 
	}
		 else {
		 	print "\t"};
    if (defined $fugu_hits{$id2}){
    	print "$fugu_hits{$id2} \t";
    }
	    else {
	    	print "\t";
	    }
    if (defined $medaka_hits{$id2}){
    	print "$medaka_hits{$id2} \t";
    }
	    else{
	    	print "\t";
	    }
    if (defined $platy_hits{$id2}){
    	print "$platy_hits{$id2} \t";
    }
	    else{
	    	print "\t";
	    }
    if (defined $stickle_hits{$id2}){
    	print "$stickle_hits{$id2} \t";
    } 
	    else{
	    	print "\t";
	    }
    if (defined $tetrodadon_hits{$id2}){
    	print "$tetrodadon_hits{$id2} \t";
    }
	    else{
	    	print "\t";
	    }
    if (defined $tilapia_hits{$id2}){
    	print "$tilapia_hits{$id2} \t";
    }
		else{
			print "\t";
			}
    if (defined $xenopus_hits{$id2}){
    	print "$xenopus_hits{$id2} \t";
	    }
	    else{
	    	print "\t";
	    }
    print "\n";
}