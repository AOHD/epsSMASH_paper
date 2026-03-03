import argparse
import os
from collections import defaultdict
from Bio import SearchIO, SeqIO

FASTA_PATH = "epsSMASH_paper/results/pel-like/extracted_proteins.fasta"
TBL_PATH = "epsSMASH_paper/results/pel-like/phmmer.tbl"
OUTDIR = "epsSMASH_paper/results/pel-like/split_fasta"

def parse_phmmer_tbl(tbl_path):
    """
    Parse phmmer --tblout using Bio.SearchIO.
    Returns dict: query_name -> set(target_ids)
    """
    hits_by_query = defaultdict(set)
    
    for qresult in SearchIO.parse(tbl_path, "hmmer3-tab"):
        query_id = qresult.id
        
        for hit in qresult.hits:
            target_id = hit.id
            hits_by_query[query_id].add(target_id)
    
    return hits_by_query


def split_fasta_by_query(fasta_path, hits_by_query, outdir):
    os.makedirs(outdir, exist_ok=True)
    
    seqs = SeqIO.to_dict(SeqIO.parse(fasta_path, "fasta"))
    
    for query, target_ids in hits_by_query.items():
        out_fasta = os.path.join(outdir, f"{query}.fasta")
        records = []
        
        for tid in target_ids:
            if tid in seqs:
                records.append(seqs[tid])
            else:
                print(f"[!] Sequence not found in FASTA: {tid}")
        
        if records:
            SeqIO.write(records, out_fasta, "fasta")
            print(f"[+] {query}: wrote {len(records)} sequences")

if __name__ == "__main__":
    hits_by_query = parse_phmmer_tbl(TBL_PATH)
    split_fasta_by_query(FASTA_PATH, hits_by_query, OUTDIR)
