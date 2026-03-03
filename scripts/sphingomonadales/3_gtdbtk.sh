#!/usr/bin/bash -l
#SBATCH --job-name=gtdbtk_tree
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_analyses/logs/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=high-mem
#SBATCH --cpus-per-task=40
#SBATCH --mem=200G
#SBATCH --time=0-06:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

#Set working directory
WD=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/sphingomonadales
cd $WD

ODIR=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/gtdbtk
mkdir -p $ODIR

# variables
THREADS=$(nproc)


GENOMES=genomes/

# # activate conda env
eval "$(conda shell.bash hook)"

conda activate gtdbtk-2.4.1


gtdbtk classify_wf --genome_dir $GENOMES \
                    --out_dir $ODIR \
                    --cpus $THREADS \
                    -x fna --skip_ani_screen
