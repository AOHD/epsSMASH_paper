cut -f1 /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/sphingomonadales/gtdb_HQ_SpRep_Sphingomonadales_metadata.tsv | while read LINE
do ln -s /databases/gtdb-tk/release226/gtdb_proteins_aa_reps/protein_faa_reps/bacteria/$LINE\_protein.faa.gz /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/sphingomonadales/proteins
done

#!/bin/bash

DATAPATH='/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/data/sphingomonadales/gtdb_HQ_SpRep_Sphingomonadales_metadata.tsv'

cut -f1 $DATAPATH | while read f
do 
ln -s /databases/gtdb-tk/release220/gtdb_genomes_reps_r220/database/${f:3:3}/${f:7:3}/${f:10:3}/${f:13:3}/*.fna /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/sphingomonadales/genomes
done
