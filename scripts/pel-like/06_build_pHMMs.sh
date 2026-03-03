conda activate hmmer_v3.4

for file in epsSMASH_paper/results/pel-like/custom_trim/*
    do filename=$(basename $file .fasta)
    echo $filename
    hmmbuild epsSMASH_paper/results/pel-like/hmms/$filename.hmm $file
done