#!/usr/bin/bash -l
#SBATCH --job-name=bigscape_HumGut_0.4
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/bigscape/slurmlog/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --cpus-per-task=150
#SBATCH --mem=150G
#SBATCH --time=0-6:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

conda activate bigscape 

cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/

bigscape cluster -i epsSMASH_paper/bigscape/HumGut/regions -o epsSMASH_paper/bigscape/HumGut/output_2 -p bigscape/pfam/Pfam-A.hmm -c 150 --force-gbk --gcf-cutoffs 0.4