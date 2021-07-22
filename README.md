# pMHC2Pred: Structural Interaction Fingerprinting of MHC Class II HLA-DR B1 gene Peptide and Affinity Estimation using Machine Learning Approach
Information on MHC class II restricting peptides is profoundly wanted in immunological research, especially with regards to cancer, autoimmune diseases, or sensitivities. The effective techniques for predictions mostly depend on machine learning methods prepared on sequences of experimentally characterized binding peptides. Here, we portray a reciprocal methodology called pMHC2Pred, which depends on Structural collaboration fingerprints (SIFTs) of MHC II-peptide complexes and physico chemical descriptors of peptide. The MHC II complexes were processed and NetMHCIIpan 3.2 peptide dataset were utilized to plan regression models dependent on Structural Interaction Fingerprints.
Biases modeling of peptide sequence datasets were done to optimize binding with corresponding MHC II molecule. SIFTs were created to recognize associating buildups of MHC class II molecule and type of interactions. Shell based scripts were composed for the atomization of the procedure to obtain SIFTs. Regression models were constructed utilizing random forest method (RF) to foresee peptide affinity for the sequence length 9-19. Finally, we provide evidence that pMHC2Pred can complement the current structure and machine learning based methods and help to predict peptide affinity. 



# Prerequisites for pMHC2Pred:

  # Data
      Peptide sequences 
  # Tools
      1. Bioprot, Protein descriptor calculator 
             Link for web server: http://biotriangle.scbdd.com/protein/index/ 
      2. FoldX  
            Download and manual: http://foldxsuite.crg.eu/documentation#manual 
      3. ZDOCK
            Download and manual: http://zdock.umassmed.edu/software/
      4. PyPLIF-HIPPOS
            Download and manual: https://github.com/radifar/PyPLIF-HIPPOS 
      5. Weka v3.8
            Download: https://www.cs.waikato.ac.nz/ml/weka/downloading.html 
    
    -------Refer the manual of the tools for the ease of the downloading and installation procedure and keep all the tools and scripts in one folder----------
    -------Put FoldX, Zdock and PyPLIF-HIPPOS in same folder as well as install PyPLIF-HIPPOS--------

# STEP-I: Descriptor calculation
    • 	To get physio-chemical descriptors of peptide make a FASTA file having peptide sequences and upload on the website of Bioprot, select “Moran autocorrelation” and submit, it will generate excel sheet of descriptors, download it and keep in a folder.
    
# STEP-II: Generation of peptide models
    •	Register on website of FoldX for educational license and download tar.gz file from provided link extract the files in a folder.
    •	The template and peptide sequence length has to be same. copy the pdb and temp.txt file from the folder of foldx_1 according to length of peptide sequences and paste to folder having sequence list text file and script foldx_1.pl.
       	 •   For example, it the peptide sequence length is 9 then copy the pdb file and temp.txt file from 9mer of folder foldx_1 and paste it to the destination folder having FoldX downloaded file, sequence text file having 9mer peptide sequence and script. 
    •	Have the peptide sequence text file, template file of same peptide length and perl script in the same folder.
    •	Run the perl script foldx_1.pl it will generate the models. Give the command as follow:
             perl foldx_1.pl [template.txt] [sequencelist.txt] [peptide pdb file]

# STEP-III: Docking of peptide models
    •	For the docking have the peptide models generated using foldx, zdock downloaded files, length specific receptor pdb from folder zdock_2 in the same folder.
    •	Execute the zdock_2.sh script to run the docking and it will generate a zdock.out file which the dock score and a zdock.out.pdb file which is the pdb of docked complex.
             bash zdock_2.sh 
    •	The script will check for the receptor pdb file starting with “Prot” and peptide starting with “Lig” and execute zdock command for to run docking which will generate the result as zdock.out file so script run the command to get docked complex pdb file from .out file.

# STEP-IV: SIFTs generation
    •	Install PyPLIF-HIPPOS using command given on the site.
    •	Have hippos_3.sh, vina.conf file and docked peptide complexes in the same folder.
    •	Copy peptide length specific protein.pdbqt and corresponding config file having residue index from corresponding length name folder of hippos_3 to the folder having script and docked complexes. 
    •	Run the commands to activate PyPLIFHippos and script in terminal:
	        	 conda activate base 
	         	 conda activate hippos
	        	 bash hippos_3.sh
    •	The script will generating generate SIFTs in the csv file compile it in just a one csv file.

# STEP-V: Affinity prediction using Weka
    •	Compile Moran autocorrelation descriptors and SIFTs in one single excel sheet, remove all columns having value 0 and insert at the end give name “Affinity” and save the csv file.
    •	Download weka 3.8, Click on “explorer” and load the csv file, select all the attributes and save the file in .arff format.
    •	Now, load the length specific model from the folder weka_model, select the “supplied test set” and set. Open the .arff file and Class – (Num) Activity. After following all the steps right click on the model to select “Reevaluate on current test set”. 
    •	The results will be displayed in the white space of “Classifier output”. It will show binding affinity predictions for the MHC-II and peptide complexes under the “predicted” and “actual” column also correlation coefficient.



References:

    1. Istyastono, E., Radifar, M., Yuniarti, N., Prasasty, V. and Mungkasi, S., 2020. PyPLIF HIPPOS: A Molecular Interaction Fingerprinting Tool for Docking Results of AutoDock Vina and PLANTS. Journal of Chemical Information and Modeling, 60(8), pp.3697-3702.
    2. Chen, R., & Weng, Z. (2003). A novel shape complementarity scoring function for protein‐protein docking. Proteins: Structure, Function, and Bioinformatics, 51(3), 397-408.
    3. Martin, T. M., Harten, P., Young, D. M., Muratov, E. N., Golbraikh, A., Zhu, H., & Tropsha, A. (2012). Does rational selection of training and test sets improve the outcome of QSAR modeling?. Journal of chemical information and modeling, 52(10), 2570-2578.
    4. Van Durme, Joost, Javier Delgado, Francois Stricher, Luis Serrano, Joost Schymkowitz, and Frederic Rousseau. "A graphical interface for the FoldX forcefield." Bioinformatics 27, no. 12 (2011): 1711-1712.
    5. Attwal, K. P. S., & Dhiman, A. S. (2020). Exploring data mining tool-Weka and using Weka to build and evaluate predictive models. Advances and Applications in Mathematical Sciences, 19(6), 451-469.
