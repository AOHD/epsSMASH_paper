# Code for epsSMASH paper
Repository for data analysis and figure generation in epsSMASH paper

## Repository structure

**data/**\
Contains the data used by the Rmd files in the main directory for generating the figure and analyses in the paper.

The script for generating Supplementary figures 3 and 8 refers to `gene_info.tsv` files, which contain gene-level information about epsSMASH BGC results. These were generated from the epsSMASH results for each genome catalogue using a custom multismash_parser python script (https://github.com/AOHD/multismash_parser) and have been included in the Github repository in a zip file, which must be extracted. The extracted folder contains four files (gene_info_HumGut.tsv, gene_info_GOMC.tsv, gene_info_MFD.tsv, gene_info_MiDAS.tsv), which must be placed in their corresponding `data/` folders (`data/HumGut/`, `data/GOMC/`, `data/MFD/`, `data/MiDAS/`). 

The script for generating Figure 6a and 6b requires the bacterial metadata file for GTDB Release 226, which must be downloaded from https://data.gtdb.ecogenomic.org/releases/release226/226.0/ and placed in `data/sphingomonadales`.


**figures/**\
Contains .svg files of the figures used in the paper

**scripts/**\
Folder containing scripts used to generate the figures and analyses in the article. Rmd files contain the code for the figure mentioned in the file name. For figure 3, the GOMC, MFD, MiDAS_Global and HumGut .Rmd files must be run before Fig3.Rmd can be run. The Rmd files pull data from `data/` to create the figures, e.g. the `all_regions.tsv` which were created by running epsSMASH via multismash on the four large genome catalogues. Running `R_install_requirements.R` installs all necessary libraries for running the Rmd files.


Bigscape bash scripts create sequence similarity networks from the epsSMASH output from the four genome catalogues using BiG-SCAPE 2.0.0b5. 


The `pel-like` directory contains scripts for creating novel pel pHMMs as described in the article. `sphingomonadales` contains scripts for gene-calling sphingomonadales MAGs from GTDB, searching for PEP-CTERM and exosortase genes in them as well as creating their phylogenomic tree. The software used in these scripts as well as versions is listed in the files. 


`contig.stats.sh` was used to calculate the contig stats of the genomes in the four genome cataloges.

**results/**\
Results contains output from the scripts in the `scripts/` directory. `results/10kcore` contains metadata files for iTOL tree annotation. In `results/bigscape/`,  the BiG-SCAPE output network files can be found, which can be visualised in e.g. Cytoscape. in `results/pel-like` and `results/sphingomonadales,` intermediary and final output files from running scripts in `scripts/pel-like` and `scripts/sphingomonadales` can be found. 

**supplemental_data/**\
Folder containing the .tsv file created in Fig3.Rmd which catalogs all exoPS BGCs detected by epsSMASH in the four genome catalogues.