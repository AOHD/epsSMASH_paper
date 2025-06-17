cut -f 1 epsSMASH_paper/data/HumGut/HumGut_HQ_derep_genome_ids.tsv | while read -r filename; do
    echo "Processing $filename"
    src_dir="epsSMASH_analyses/HumGut/data/epsSMASH_results/antismash/$filename"
    dest_dir="epsSMASH_paper/bigscape/HumGut/regions"
    
    if [ -d "$src_dir" ]; then
        # Copy all region GBK files with new names
        for gbk_file in "$src_dir"/*region*.gbk; do
            if [ -f "$gbk_file" ]; then
                base_name=$(basename "$gbk_file")
                cp "$gbk_file" "$dest_dir/${filename}_${base_name}" 2>/dev/null
                echo "Copied $gbk_file to $dest_dir/${filename}_${base_name}"
            fi
        done
        
        # Check if any files were processed
        if [ $(ls "$src_dir"/*region*.gbk 2>/dev/null | wc -l) -eq 0 ]; then
            echo "No region files found for $filename"
        fi
    else
        echo "Directory not found: $src_dir"
    fi
done