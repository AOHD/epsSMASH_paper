#!/bin/bash

DATAPATH='results/sphingomonadales/gtdb_HQ_SpRep_Sphingomonadales_metadata.tsv'

cut -f1 $DATAPATH | while read f
do 
ln -s /databases/GTDB/gtdb_data/release226/226.0/gtdb_genomes_reps_r226/database/${f:3:3}/${f:7:3}/${f:10:3}/${f:13:3}/*.fna data/sphingomonadales/genomes
done
