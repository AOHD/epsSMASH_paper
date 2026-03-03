
conda activate usearch_v12.0_beta

for file in epsSMASH_paper/results/pel-like/split_fasta/*;
    do filename=$(basename $file)
    echo $filename
    usearch -cluster_fast $file -sort length -id 0.9 -centroids epsSMASH_paper/results/pel-like/clustering/$filename
done

conda activate mafft_7.525

for file in epsSMASH_paper/results/pel-like/clustering/*;
    do filename=$(basename $file)
    echo $filename
    einsi --thread 8 $file > epsSMASH_paper/results/pel-like/alignment/$filename
done

conda activate trimal_1.4.1

for file in epsSMASH_paper/results/pel-like/alignment/*;
    do filename=$(basename $file)
    echo $filename
    trimal -in $file -out epsSMASH_paper/results/pel-like/trimal/$filename -gt 0.75
done

