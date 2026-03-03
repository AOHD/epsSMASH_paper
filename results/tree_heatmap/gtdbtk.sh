#!/usr/bin/bash -l
#SBATCH --job-name=gtdbtk_tree
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_analyses/logs/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=high-mem
#SBATCH --cpus-per-task=40
#SBATCH --mem=150G
#SBATCH --time=0-06:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

#Set working directory
WD=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/tree_heatmap
cd $WD

# variables
THREADS=$(nproc)
ODIR=gtdbtk
mkdir -p $ODIR

GENOMES=genomes/

mkdir -p $GENOMES

cut -f 1 $WD/heatmap_tree_genomes.tsv | while read -r filename; do
    echo $filename
    if [[ "$filename" == 'genome_id' ]]; then
        continue
    fi
    cp /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_analyses/MiDAS/data/derep_HQ_MAGs/$filename.fa genomes/
done

# # activate conda env
eval "$(conda shell.bash hook)"

conda activate gtdbtk-2.4.1


gtdbtk classify_wf --genome_dir $GENOMES \
                    --out_dir $ODIR \
                    --cpus $THREADS \
                    -x fa --skip_ani_screen --debug
