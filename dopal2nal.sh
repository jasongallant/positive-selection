#!/bin/bash
FILES=../step6_prank_align/*.fasta.2.fas
for f in $FILES
do
  echo ""
  # take action on each file. $f store current file name
  k=$(basename "$f")
  nucleotidename=${k%\.*\.*}
  echo "Processing $k..."
  perl ../scripts/pal2nal.pl $f ../step5_fasta_files/nucleotides/$nucleotidename -output paml -nogap -nomismatch > $k.codon
done