Step 1: ENSEMBL BioMart Export
================================

Downloaded from ENSEMBL BIOMART using the following protocol for each species:

  - go to http://useast.ensembl.org/biomart/martview/
  - Choose Database: Ensembl Genes 70
  - Choose Dataset Danio rerio genes (Zv9)
  - Apply Filters (left toolbar): MULTI SPECIES COMPARISIONS : Orthologous [SPECIES OF INTEREST] Genes
  - Choose Attributes: Homologs: Orthologs Select [Species of Interest Gene ID and Transcript ID]
  - Click Results
  - Click Export all results to TSV File

Step 2&3: Filter One2One Ortholog Mappings
================================

Use awk to remove anything that isn't one2one.  This will still include those orthologs that are labeled "apparent_one2one".  perform a second awk to remove these.


Step 4: Construct an Ortholog Table 
================================
Using the 29K dataset from eel (located in the resources folder), wrote a perl script to take each gene and look up the orthologs from these datasets using this perl script:


This constructs a protein homolog table.  If you want a transcript table, use the following code to translate the table to transcript IDs.

Step 5: Generate FASTA Files of Sequences
================================
To get this running, you have to download the cDNA and protein files for each fish from the ENSEMBL FTP site

http://useast.ensembl.org/info/data/ftp/index.html

Once this is completed, use the following perl script to construct a fasta file for each protein in the table.


Step 6: Perform PRANK Alignments =
================================
PRANK is a probabilistic aligner.  I used default settings and had the batch manager run each alignment (~30sec-1min per protein) on the BU Katana Cluster.



Step 7: Translate Protein to Codon Alignment
================================
Because dN/dS ratios are calculated on nucleotides, not proteins, everything has to be made into a codon alignment.  There are a few programs to do this, Pal2Nal was the one suggested to me.  It is a perl script.

Pal2Nal was run on each of the alignments as follows:


Step 8: Run PAML 
================================
PAML is an incredibly complex suite of programs with many options to configure.  Controlling the program is relatively straightforward and can be done with either perl or python, as can extracting the results, which is more challenging.  I found the python interface (Provided through BioPython) to be a little easier to understand, thus I wrote the instructions to run PAML and parse it in python.

This is a script runs a very simple experimental design (they can get much more complex!)-- essentially the instructions tell PAML to use the phylogeny from all fishes to compare a "global" dS/dN ratio (null hypothesis) to a "local" dS/dN ratio (alt. hypothesis) in E. electrophorus.  A third comparison is made between this tree and a tree where a dN/dS of 1 is selected (neutral evolution).  Comparision 1-2 tests for significant differences between "foreground (eel) brach and background branches, whereas comparison 2-3 tests for signifiant departures from neutral evolution (dN/dS=1).

This requires a tree topology, which was specified as following.  Note that intermediate working files are deleted after a run!

<code>
((((Danio_rerio,Electrophorus_electricus#1),(Gadus_morhua,(Oreochromis_niloticus,(Tetraodon_nigroviridis,Takifugu_rubripes),(Gasterosteus_aculeatus,(Xiphophorus_maculatus,Oryzias_latipes))))),Xenopus_tropicalis));
</code>

The following code executes the comparison on a single codon alignment:



To run this code in batch, I wrote a quick submission script:

<code bash>
    #!/bin/bash
     FILES=/projectnb/mullenl/data/eel_positive_selection/#Step7_alt_pal2nal/*.co    don
    for f in $FILES
    do
      # take action on each file. $f store current file name
      qsub -V -b y -j y /usr2/postdoc/jrg1/bin/python2.7 ../scripts/runpaml_eel.py      $f
    done
    </code>


Step 9: Consolidate Results
================================
Once the PAML calculations are made, each resides in a separate file.  This simple perl script concatenates the results into a single file:

