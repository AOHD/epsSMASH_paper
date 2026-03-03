# Import modules
from Bio import SearchIO
import pandas as pd
import os
from os.path import isfile, join
import re
import multiprocessing as mp
from itertools import chain
import json

# Parameters
SearchIO_command="hmmer3-tab"
ncores = 10

def parse_hmmsearch(file):
    hits = []
    # Extract filename and remove "_genomic" suffix if present
    filename = os.path.basename(file)  # Get just the filename without path
    if filename.endswith("_genomic.txt"):
        filename = filename[:-12]  # Remove the last 8 characters "_genomic"
    
    if SearchIO_command == "hmmsearch3-domtab":
        for query in SearchIO.parse(file, SearchIO_command):
            query_id = query.id
            for hit in query.hits:
                for hsp in hit.hsps:
                    row = {}
                    row["query"] = query_id
                    row["target"] = hit.id
                    row["Query length"] = hit.seq_len
                    row["evalue_ind"] = hsp.evalue
                    row["evalue_cond"] = hsp.evalue_cond
                    row["bitscore_domain"] = hsp.bitscore
                    row["description"] = " " + hit.description
                    row["domain_start"] = hsp.hit_start
                    row["domain_end"] = hsp.hit_end
                    row["genome"] = filename
                    hits.append(row)
    elif SearchIO_command == "hmmer3-tab":
        for query in SearchIO.parse(file, SearchIO_command):
            query_id = query.id
            for hit in query:
                row = {}
                row["query"] = query_id
                row["target"] = hit.id
                row["evalue"] = hit.evalue
                row["bitscore"] = hit.bitscore
                row["description"] = " " + hit.description
                row["inclusion"] = hit.domain_included_num
                row["genome"] = filename
                hits.append(row)
    else:
        print("Invalid SearchIO command")
    return hits

def parse_hmmsearch_safe(file):
    try:
        return parse_hmmsearch(file)
    except Exception as e:
        print(f"Error processing file: {file}")
        print(f"Error message: {str(e)}")
        return []  # return empty list for this file, or you could re-raise


# Set path to folder with hmmsearch results
input_dir="/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/hmmsearch/pepcterm"
output_file="/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/hmmsearch/pepcterm.csv"

# Get the list of all files in directory tree at given path
listOfFiles = list()
for (dirpath, dirnames, filenames) in os.walk(input_dir):
    listOfFiles += [os.path.join(dirpath, file) for file in filenames]


with mp.Pool(ncores) as pool:
    hits = pool.map(parse_hmmsearch_safe, listOfFiles)

# Since we use mp.pool, we have to flatten the list of lists that it creates
hits_flat = list(chain(*hits))

# Convert the list of dictionaries to a pandas dataframe
df = pd.DataFrame(hits_flat)
# Split the description column on " # " and get the 1:4 elements, which are the coordinates
df["coordinates"] = df.apply(lambda row: "_".join(row.description.split(" # ")[1:4]), axis=1)
df = df.drop(columns=["description"])

df["accession"] = df.apply(lambda row : re.match("^(.+)_", row.target)[1], axis=1)

df.to_csv(output_file, index=False)


# Set path to folder with hmmsearch results
input_dir="/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/hmmsearch/exosortase"
output_file="/home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper/results/sphingomonadales/hmmsearch/exosortase.csv"

# Get the list of all files in directory tree at given path
listOfFiles = list()
for (dirpath, dirnames, filenames) in os.walk(input_dir):
    listOfFiles += [os.path.join(dirpath, file) for file in filenames]


with mp.Pool(ncores) as pool:
    hits = pool.map(parse_hmmsearch_safe, listOfFiles)

# Since we use mp.pool, we have to flatten the list of lists that it creates
hits_flat = list(chain(*hits))

# Convert the list of dictionaries to a pandas dataframe
df = pd.DataFrame(hits_flat)
# Split the description column on " # " and get the 1:4 elements, which are the coordinates
df["coordinates"] = df.apply(lambda row: "_".join(row.description.split(" # ")[1:4]), axis=1)
df = df.drop(columns=["description"])

df["accession"] = df.apply(lambda row : re.match("^(.+)_", row.target)[1], axis=1)

df.to_csv(output_file, index=False)