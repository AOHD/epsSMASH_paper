#!/usr/bin/bash -l
#SBATCH --job-name=bigscape_Sphingomonadaceae_0.4
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/bigscape/slurmlog/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --cpus-per-task=100
#SBATCH --mem=100G
#SBATCH --time=0-06:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

conda activate bigscape 

cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/

bigscape cluster -i epsSMASH_analyses/MiDAS/data/Sphingomonadaceae/epsSMASH_results_all/antismash -o epsSMASH_paper/bigscape/Sphingomonadaceae_NCBI/output_all -p bigscape/pfam/Pfam-A.hmm -c 100 --force-gbk --gcf-cutoffs 0.4