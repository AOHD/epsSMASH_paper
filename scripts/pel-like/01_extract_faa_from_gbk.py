import os
import pandas as pd
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord
from Bio.Seq import Seq


# --- CONFIGURATION ---
CSV_PATH = "epsSMASH_paper/results/pel-like/pel_like_genes_metadata.csv"
INPUT_FOLDER = "epsSMASH_paper/results/pel-like/epsSMASH_results/antismash"
OUTPUT_FASTA = "epsSMASH_paper/results/pel-like/extracted_proteins.fasta"


def extract_proteins():
    if not os.path.exists(CSV_PATH):
        print(f"Error: CSV not found at {CSV_PATH}")
        return
	
    # Load headerless CSV
    df = pd.read_csv(CSV_PATH, header=None, names=["genome_id", "gene_id"])
    
    found_ids = set()
    all_protein_records = []
    
    # Group by genome to minimize file opening
    for genome_id, group in df.groupby("genome_id"):
        gbk_path = os.path.join(
            INPUT_FOLDER,
            str(genome_id),
            f"{genome_id}.gbk"
        )
        
        target_genes = set(group["gene_id"].astype(str).str.strip())
	    
        if not os.path.exists(gbk_path):
            print(f"[-] Missing File: {gbk_path}")
            continue
        
        print(f"[*] Processing {genome_id}...")
        
        # Parse GBK
        for record in SeqIO.parse(gbk_path, "genbank"):
            for feature in record.features:
                if feature.type != "CDS":
                    continue
                
                qualifiers = feature.qualifiers
                
                # Check for match in common ID fields
                for key in ["locus_tag", "gene", "protein_id"]:
                    if key not in qualifiers:
                        continue
				    	
                    val = qualifiers[key][0]
                    
                    if val not in target_genes:
                        continue
                    
                    if "translation" not in qualifiers:
                        continue
                    
                    # Success: Record found
                    new_rec = SeqRecord(
                        Seq(qualifiers["translation"][0]),
                        id=f"{genome_id}|{val}",
                        description=f"source:{gbk_path}",
                    )
                    
                    all_protein_records.append(new_rec)
                    found_ids.add((genome_id, val))
                    break
    
    # Save to FASTA
    if all_protein_records:
        SeqIO.write(all_protein_records, OUTPUT_FASTA, "fasta")
        print(f"\n[+] Saved {len(all_protein_records)} sequences to {OUTPUT_FASTA}")
    
    print_missing_report(df, found_ids)


def print_missing_report(df, found_ids):
    missing = []
    
    for _, row in df.iterrows():
        key = (row["genome_id"], str(row["gene_id"]).strip())
        if key not in found_ids:
            missing.append(f"{row['genome_id']} -> {row['gene_id']}")
    
    print(f"\nTotal Requested: {len(df)}")
    print(f"Total Found:     {len(found_ids)}")
    
    if missing:
        print(f"Total Missing:   {len(missing)}")
        print("First 5 missing entries:")
        for item in missing[:5]:
            print(f" [ ] {item}")


if __name__ == "__main__":
    extract_proteins()
