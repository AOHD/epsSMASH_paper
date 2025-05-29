cut -f 1 epsSMASH_paper/data/GOMC/GOMC_HQ_genome_ids.tsv | while read -r filename; do
    echo "Processing $filename"
    src_dir="epsSMASH_analyses/GOMC/data/epsSMASH_results/antismash/$filename"
    dest_dir="epsSMASH_paper/bigscape/GOMC/regions"
    
    if [ -d "$src_dir" ]; then
        # Copy all region GBK files
        cp "$src_dir"/*region*.gbk "$dest_dir/" 2>/dev/null
        
        # Check if any files were copied
        if [ $? -eq 0 ]; then
            echo "Copied region files from $filename"
        else
            echo "No region files found for $filename"
        fi
    else
        echo "Directory not found: $src_dir"
    fi
done