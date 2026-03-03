#!/usr/bin/bash -l
#SBATCH --job-name=iqtree
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_analyses/logs/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --cpus-per-task=100
#SBATCH --mem=150G
#SBATCH --time=0-03:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

#Set working directory
WD=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/sphingomonadales
cd $WD

ODIR=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/tree
mkdir -p $ODIR

# variables
THREADS=$(nproc)
FULL_MSA=/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/gtdbtk/align/gtdbtk.bac120.msa.fasta.gz


# I choose o__Rickettsiales as an outgroup (2 spp)
# RS_GCF_021378375.1 Wolbachia pipientis
# RS_GCF_000215485.1 Anaplasma marginale

# make a list of IDs of all genomes to include
GENOMES=genomes
ls $GENOMES | grep '.fna' | sed 's/\.fna$//' > $ODIR/mags_to_screen.txt


echo -e 'RS_GCF_021378375.1\nRS_GCF_000215485.1' >> $ODIR/mags_to_screen.txt # add outgroup genomes

conda activate fxtract_v2.4
fxtract -H -f $ODIR/mags_to_screen.txt $FULL_MSA > $ODIR/MSA_sphingomonadales_tree_subset_for_IQtree.faa
conda deactivate

# # activate conda env
eval "$(conda shell.bash hook)"

# Activate the Conda environment
conda activate iqtree

echo "Building your fantastic tree 🌳🌳🌳🌳"

# #IQ-TREE multicore version 2.2.0.3
MSA=$ODIR/MSA_sphingomonadales_tree_subset_for_IQtree.faa
# ultrafast bootsbootstrapping
iqtree2 -s $MSA -m WAG+G -B 1000 -T AUTO --threads-max 9 -o RS_GCF_021378375.1,RS_GCF_000215485.1 -n 120
conda deactivate