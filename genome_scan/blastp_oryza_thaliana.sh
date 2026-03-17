#!/bin/bash
#SBATCH --job-name=blastp_oryza_thaliana
#SBATCH --time=96:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=24
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
module load BLAST+/2.13.0-gompi-2022a


blastp -query marram_proteins.fasta -db ath_rice_sprot -outfmt "6" -evalue 1e-5 -max_target_seqs 5 -num_threads 24 -out marram_vs_ath_rice.tsv