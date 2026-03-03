#!/usr/bin/env bash

set -euo pipefail

TABLE="results/uncharacterised/uncharacterised_GCFs_named.tsv"
GBK_DIR="data/MiDAS/epsSMASH_results/antismash"
OUTDIR="results/uncharacterised/sampled_BGCs"

mkdir -p "$OUTDIR"

# Skip header, get unique product_new values
tail -n +2 "$TABLE" | cut -f2 | sort -u | while read -r product; do
    echo "Processing: $product"

    # Create safe directory name (replace spaces with _)
    product_dir="${OUTDIR}/${product// /_}"
    mkdir -p "$product_dir"

    # Get 10 random genome_ids for this product
    genome_ids=$(awk -F'\t' -v p="$product" '$2 == p {print $1}' "$TABLE" | shuf -n 10)

    for gid in $genome_ids; do
        # Find matching gbk file
        gbk_file=$(find "$GBK_DIR" -type f -name "*${gid}*.gbk" | head -n 1)

        if [[ -n "$gbk_file" ]]; then
            cp "$gbk_file" "$product_dir/"
        else
            echo "WARNING: .gbk not found for $gid" >&2
        fi
    done
done

conda activate clinker

for dir in $(ls $OUTDIR);
    do clinker $OUTDIR/$dir --plot $OUTDIR/$dir.html
done

