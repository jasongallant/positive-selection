#!/bin/bash
FILES=../step5_fasta_files/proteins/*.fasta
for f in $FILES
do
  echo ""
  # take action on each file. $f store current file name
  k=$(basename "$f")
  name=${k%\.*}
  echo "Processing $name..."
  #echo "qsub -V -j y -o $name.logfile -b y prank -d=$f -o=$k"
  qsub -V -j y -o $name.logfile -b y prank -d=$f -o=$k
done