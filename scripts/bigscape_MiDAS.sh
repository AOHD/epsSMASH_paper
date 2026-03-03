#!/usr/bin/bash -l
#SBATCH --job-name=bigscape_MiDAS_core_0.4
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/bigscape/slurmlog/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=300G
#SBATCH --time=0-12:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

conda activate bigscape 

cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/

bigscape cluster -i epsSMASH_paper/data/MiDAS/epsSMASH_results_10k_core/antismash -o epsSMASH_paper/results/bigscape/core/ -p bigscape/pfam/Pfam-A.hmm -c 20 --force-gbk --gcf-cutoffs 0.4