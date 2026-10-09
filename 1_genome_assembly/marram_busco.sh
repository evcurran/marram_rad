#!/bin/bash
#SBATCH --job-name=busco_marram
#SBATCH --output=busco_marram.out
#SBATCH --error=busco_marram.err
#SBATCH --time=12:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8

# Load conda environment
source ~/miniconda3/etc/profile.d/conda.sh
conda activate busco-env || { echo "Error: BUSCO environment failed to activate"; exit 1; }

# Define inputs
INPUT_FASTA="/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/hifiasm_26858_2G_nhap_4.bp.p_ctg.fasta"
LINEAGE="embryophyta_odb10"
OUTPUT_NAME="marram_busco"
MODE="genome"
OUTPUT_DIR="/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/BUSCO"

# Run BUSCO
mkdir -p "$OUTPUT_DIR"
cd "$OUTPUT_DIR"

busco \
  -i "$INPUT_FASTA" \
  -l "$LINEAGE" \
  -o "$OUTPUT_NAME" \
  -m "$MODE" \
  -c 8

echo "BUSCO completed for $INPUT_FASTA"

