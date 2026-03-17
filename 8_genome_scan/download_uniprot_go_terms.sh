#!/bin/bash
#SBATCH --job-name=download_go_terms
#SBATCH --time=96:00:00
#SBATCH --mem=150G
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc

# caution - this is a big file
wget https://ftp.ebi.ac.uk/pub/databases/GO/goa/UNIPROT/goa_uniprot_all.gaf.gz
gunzip goa_uniprot_all.gaf.gz


awk '$1 !~ /^!/ {print $2, $5}' goa_uniprot_all.gaf > uniprot2go.txt
