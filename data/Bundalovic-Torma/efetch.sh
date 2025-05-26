# Download all genomes from the genomes.txt file
cat /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/Bundalovic-Torma/rerun_genomes.txt | parallel -j 1 'efetch -db nuccore -id {} -format genbank -style gbwithparts > /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/Bundalovic-Torma/genomes/{}.gb 2>> /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/Bundalovic-Torma/error2.log'

# Check if all files were downloaded
while IFS= read -r name; do
  if [[ ! -f /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/Bundalovic-Torma/genomes/$name.gb ]]; then
    echo "File for $name not found!" >> /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/Bundalovic-Torma/missing_files.log
  fi
done < /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/Bundalovic-Torma/genomes.txt