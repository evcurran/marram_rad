#!/bin/bash
#SBATCH --job-name=helixer
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --time=96:00:00
#SBATCH --output=helixer_%j.out
#SBATCH --error=helixer_%j.err
#SBATCH --mem=32G

# Paths
GENOME=/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/hifiasm_26858_2G_nhap_4.bp.p_ctg.fasta
MODEL=/mnt/parscratch/users/bop24erb/helixer_models/
OUTPUT=/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/Helixer/output
SIF=/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/Helixer/helixer.sif
HELIXER_SCRIPT=/usr/local/bin/Helixer.py

mkdir -p $OUTPUT

# Run Helixer
apptainer exec \
--bind /mnt:/mnt \
$SIF \
python3 /usr/local/bin/Helixer.py \
--fasta-path $GENOME \
--model-filepath /mnt/parscratch/users/bop24erb/helixer_models/land_plant_v0.3_a_0080.h5 \
--gff-output-path $OUTPUT/predictions.gff3 \
--lineage land_plant \
--subsequence-length 64152

