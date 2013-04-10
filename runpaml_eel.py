from Bio.Phylo.PAML import codeml
import os
import sys
import shutil

alignmentfile = sys.argv[1]
filename=os.path.basename(alignmentfile)
genename=filename.split('.')[0]

# estimate global dN/dS
working_directory="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename
if not os.path.exists(working_directory):
	os.makedirs(working_directory)
cml = codeml.Codeml(alignment=alignmentfile, 
	tree="/projectnb/mullenl/data/eel_positive_selection/resources/tree/speciestree.phy", 
	out_file="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename+".eel.global.codon",
	working_dir=working_directory
	)
cml.set_options(
	verbose = True, 
	NSsites="0", 
	model=0, 
	seqtype=1,
	)
cml.ctl_file="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename+".eel.global.ctl"
try:
	globalres=cml.run()
except:
	res= None

if not os.path.exists(working_directory):
	os.makedirs(working_directory)
# estimate branch dN/dS
cml = codeml.Codeml(alignment=alignmentfile, 
	tree="/projectnb/mullenl/data/eel_positive_selection/resources/tree/speciestree.phy", 
	out_file="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename+".eel.branch.codon",
	working_dir=working_directory)
cml.set_options(
	verbose = True, 
	NSsites="0", 
	model=2, 
	seqtype=1,
	)
cml.ctl_file="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename+".eel.branch.ctl"
try:
	branchres=cml.run()
except:
	branchres= None

# estimate null
if not os.path.exists(working_directory):
	os.makedirs(working_directory)
cml = codeml.Codeml(alignment=alignmentfile, 
	tree="/projectnb/mullenl/data/eel_positive_selection/resources/tree/speciestree.phy", 
	out_file="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename+".eel.null.codon",
	working_dir=working_directory)
cml.set_options(
	verbose = True, 
	NSsites="0", 
	model=2, 
	seqtype=1,
	fix_omega =1,
	omega =1
	)
cml.ctl_file="/projectnb/mullenl/data/eel_positive_selection/step8_paml/"+genename+".eel.null.ctl"
try:
	nullres=cml.run()
except:
	nullres= None


#calculate degrees of freedom (n params)
a=globalres['NSsites'][0]["parameters"]["parameter list"].split(" ")
global_df=len(a)
#return dn/dS ratios (two for branch model)
global_omega=globalres['NSsites'][0]["parameters"]["omega"]
#return kappa
global_kappa=globalres['NSsites'][0]["parameters"]["kappa"]
#return lnL
global_lnL=globalres['NSsites'][0]["lnL"]

#calculate degrees of freedom (n params)
b=branchres['NSsites'][0]["parameters"]["parameter list"].split(" ")
branch_df=len(b)
#return dn/dS ratios (two for branch model)
branch_omega=branchres['NSsites'][0]["parameters"]["omega"]
#return kappa
branch_kappa=branchres['NSsites'][0]["parameters"]["kappa"]
#return lnL
branch_lnL=branchres['NSsites'][0]["lnL"]

#calculate degrees of freedom (n params)
c=nullres['NSsites'][0]["parameters"]["parameter list"].split(" ")
null_df=len(c)
#return dn/dS ratios (two for branch model)
null_omega=nullres['NSsites'][0]["parameters"]["omega"]
#return kappa
null_kappa=nullres['NSsites'][0]["parameters"]["kappa"]
#return lnL
null_lnL=nullres['NSsites'][0]["lnL"]


teststat_for_eel=2*(branch_lnL-global_lnL)
testdf_for_eel=(branch_df-global_df)
# test_pval_for_eel=cdf_chi2(testdf_for_eel,teststat_for_eel)

teststat_for_pos=2*(branch_lnL-null_lnL)
testdf_for_pos=(branch_df-null_df)
# test_pval_for_pos=cdf_chi2(testdf_for_pos,teststat_for_pos)


#print the results file

outfilename=genename+"_pamlresults.txt"
with open(outfilename, "a") as myfile:
	myfile.write('%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' %(global_df,global_omega,global_kappa,global_lnL,branch_df,branch_omega[0],branch_omega[1],branch_kappa,branch_lnL,null_df,null_omega[0],null_omega[1],null_kappa,null_lnL,teststat_for_eel,testdf_for_eel,teststat_for_pos,testdf_for_pos))

#and clean up.
shutil.rmtree(working_directory)
