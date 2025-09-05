#!/usr/bin/bash -l
#SBATCH --job-name=bigscape_GOMC_0.4
#SBATCH --output=/home/bio.aau.dk/zs85xk/projects/epsSMASH/bigscape/slurmlog/job_%j_%x.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --partition=general
#SBATCH --cpus-per-task=60
#SBATCH --mem=300G
#SBATCH --time=1-00:00:00
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=aohd@bio.aau.dk

# Exit on first error and if any variables are unset
set -eu

conda activate bigscape 

cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/

bigscape cluster -i /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/bigscape/GOMC/regions -o epsSMASH_paper/bigscape/GOMC/output -p bigscape/pfam/Pfam-A.hmm -c 60 --force-gbk --gcf-cutoffs 0.4