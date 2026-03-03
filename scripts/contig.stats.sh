#!/usr/bin/env bash

# Usage: ./contig_lengths.sh genomes_dir > contig_lengths.tsv

GENOME_DIR="$1"

if [[ -z "$GENOME_DIR" || ! -d "$GENOME_DIR" ]]; then
    echo "Usage: $0 <directory_of_genomes>" >&2
    exit 1
fi

# Header
echo -e "genome\tcontig\tlength"

for genome in "$GENOME_DIR"/*; do
    [[ -f "$genome" ]] || continue

    # Choose input command
    if [[ "$genome" == *.gz ]]; then
        CMD="zcat"
        GENOME_NAME="$(basename "${genome%.gz}")"
    else
        CMD="cat"
        GENOME_NAME="$(basename "$genome")"
    fi

    $CMD "$genome" | awk -v genome="$GENOME_NAME" '
        /^>/ {
            # Print previous contig
            if (seq_len > 0) {
                printf "%s\t%s\t%d\n", genome, contig, seq_len
            }
            contig = substr($0, 2)   # contig name without ">"
            seq_len = 0
            next
        }
        {
            seq_len += length($0)
        }
        END {
            if (seq_len > 0) {
                printf "%s\t%s\t%d\n", genome, contig, seq_len
            }
        }
    '
done
