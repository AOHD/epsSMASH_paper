cd /home/bio.aau.dk/zs85xk/projects/epsSMASH/epsSMASH_paper

conda activate hmmer_v3.4

INDIR="data/sphingomonadales"
OUTDIR="results/sphingomonadales"

mkdir -p $OUTDIR/hmmsearch/exosortase/
mkdir -p $OUTDIR/hmmsearch/pepcterm/


find $INDIR/genomes/prodigal -maxdepth 1 -name "*.faa" -printf '%f\n' | sed 's/\.faa$//' | parallel -j8 hmmsearch -o /dev/null --tblout $OUTDIR/hmmsearch/exosortase/{}.txt --noali --cpu 1 $INDIR/TIGR02602.hmm $INDIR/genomes/prodigal/{}.faa

find $INDIR/genomes/prodigal -maxdepth 1 -name "*.faa" -printf '%f\n' | sed 's/\.faa$//' | parallel -j8 hmmsearch -o /dev/null --tblout $OUTDIR/hmmsearch/pepcterm/{}.txt --noali --cpu 1 $INDIR/TIGR02595.hmm $INDIR/genomes/prodigal/{}.faa