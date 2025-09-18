cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/sphingomonadales

conda activate hmmer_v3.4

find ./genomes/prodigal -maxdepth 1 -name "*.faa" -printf '%f\n' | sed 's/\.faa$//' | parallel -j8 hmmsearch -o /dev/null --tblout ./output/hmmsearch/exosortase/{}.txt --noali --cpu 1 ./TIGR02602.hmm ./genomes/prodigal/{}.faa

find ./genomes/prodigal -maxdepth 1 -name "*.faa" -printf '%f\n' | sed 's/\.faa$//' | parallel -j8 hmmsearch -o /dev/null --tblout ./output/hmmsearch/pepcterm/{}.txt --noali --cpu 1 ./TIGR02595.hmm ./genomes/prodigal/{}.faa