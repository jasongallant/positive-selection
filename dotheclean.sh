#!/bin/bash
# do
#   # take action on each file. $f store current file name
#   qsub -V -b y -j y /usr2/postdoc/jrg1/bin/python2.7 ../scripts/runpaml_eel.py $f
# done


while read data; do
    qsub -V -b y /projectnb/mullenl/programs/tabix-0.2.6/bgzip $data
done