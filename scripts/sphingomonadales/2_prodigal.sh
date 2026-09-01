cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/sphingomonadales
# Prodigal V2.6.3: February, 2016
conda activate prodigal_env
mkdir -p genomes/prodigal
find ./genomes -name "*.fna" -printf '%f\n' | sed 's/\.fna$//' | parallel -j8 prodigal -i ./genomes/{}.fna -a genomes/prodigal/{}.faa