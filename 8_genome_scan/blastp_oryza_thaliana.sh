#!/bin/bash
#SBATCH --job-name=blastp_oryza_thaliana
#SBATCH --time=96:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=24
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
module load BLAST+/2.13.0-gompi-2022a



# GO term annotation

# Rice and thaliana proteomes downloaded from UniProt
wget "https://rest.uniprot.org/uniprotkb/stream?query=reviewed:true+AND+taxonomy_id:3702&format=fasta" \
     -O ath_sprot.fasta

wget "https://rest.uniprot.org/uniprotkb/stream?query=reviewed:true+AND+taxonomy_id:4530&format=fasta" \
     -O rice_sprot.fasta


# Combine and make blast db
cat ath_sprot.fasta rice_sprot.fasta > ath_rice_sprot.fasta

# blast annotated genes against database
blastp -query marram_proteins.fasta -db ath_rice_sprot -outfmt "6" -evalue 1e-5 -max_target_seqs 5 -num_threads 24 -out marram_vs_ath_rice.tsv