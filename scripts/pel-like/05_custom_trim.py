import os
from Bio import SeqIO

# --- CONFIGURATION ---
INPUT_DIR = "epsSMASH_paper/results/pel-like/trimal"          # directory with FASTA files
OUTPUT_DIR = "epsSMASH_paper/results/pel-like/custom_trim"      # directory for filtered FASTAs
NONGAP_THRESHOLD = 0.75               # fraction of non-gap characters
FASTA_EXTENSION = ".fasta"


def remove_sequences_with_gaps_in_dir(input_dir, output_dir, gap_threshold):
    os.makedirs(output_dir, exist_ok=True)
    
    for fname in os.listdir(input_dir):
        if not fname.lower().endswith(FASTA_EXTENSION):
            continue
        
        input_path = os.path.join(input_dir, fname)
        output_path = os.path.join(output_dir, fname)
        
        filtered_sequences = []
        
        for seq in SeqIO.parse(input_path, "fasta"):
            total_length = len(seq.seq)
            if total_length == 0:
                continue
            
            gap_count = seq.seq.count("-")
            nongap_fraction = (total_length - gap_count) / total_length
            
            if nongap_fraction > gap_threshold:
                filtered_sequences.append(seq)
            
        if filtered_sequences:
            SeqIO.write(filtered_sequences, output_path, "fasta")
            print(f"[+] {fname}: kept {len(filtered_sequences)} sequences")
        else:
            print(f"[!] {fname}: no sequences passed the filter")


if __name__ == "__main__":
    remove_sequences_with_gaps_in_dir(
        INPUT_DIR,
        OUTPUT_DIR,
        NONGAP_THRESHOLD,
    )
