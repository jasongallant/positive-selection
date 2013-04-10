#!/bin/bash
FILES=/projectnb/mullenl/data/eel_positive_selection/step7_alt_pal2nal/*.codon
for f in $FILES
do
  # take action on each file. $f store current file name
  qsub -V -b y -j y /usr2/postdoc/jrg1/bin/python2.7 ../scripts/runpaml_eel.py $f
done
