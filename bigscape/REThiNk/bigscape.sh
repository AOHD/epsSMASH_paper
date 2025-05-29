#!/usr/bin/bash -l
#SBATCH --job-name=bigscape_REThiNk_HQ
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/bigscape/slurmlog/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=shared
#SBATCH --cpus-per-task=200
#SBATCH --mem=300G
#SBATCH --time=2-00:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

conda activate bigscape 

cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/

bigscape cluster -i epsSMASH_paper/bigscape/REThiNk/regions -o epsSMASH_paper/bigscape/REThiNk/output -p bigscape/pfam/Pfam-A.hmm -c 100 --force-gbk --gcf-cutoffs 0.25,0.5,0.75