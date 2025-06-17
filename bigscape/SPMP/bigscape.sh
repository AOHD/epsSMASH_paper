#!/usr/bin/bash -l
#SBATCH --job-name=bigscape_SPMP_HQ
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/bigscape/slurmlog/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --cpus-per-task=20
#SBATCH --mem=30G
#SBATCH --time=0-02:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

conda activate bigscape 

cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/

bigscape cluster -i epsSMASH_paper/bigscape/SPMP/regions -o epsSMASH_paper/bigscape/SPMP/output -p bigscape/pfam/Pfam-A.hmm -c 20 --force-gbk --gcf-cutoffs 0.25,0.5,0.75