conda activate hmmer_v3.4

phmmer --noali --cpu 8 -T 50 --tblout epsSMASH_paper/results/pel-like/phmmer.tbl epsSMASH_paper/results/pel-like/pel_like_combined.fa epsSMASH_paper/results/pel-like/extracted_proteins.fasta

