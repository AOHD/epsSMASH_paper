cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/sphingomonadales
conda activate prodigal_env

find ./genomes -name "*.fna" -printf '%f\n' | sed 's/\.fna$//' | parallel -j8 prodigal -i ./genomes/{}.fna -a genomes/prodigal/{}.faa