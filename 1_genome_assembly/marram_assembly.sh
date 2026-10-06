#!/bin/bash

#SBATCH --job-name=hifiasm
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --time=96:00:00
#SBATCH --output=hifiasm_%j.out
#SBATCH --error=hifiasm_%j.err
#SBATCH --mem=128G

# Load conda
source ~/miniconda3/etc/profile.d/conda.sh

# Activate hifiasm environment
conda activate hifiasm-env

# Paths
READS=/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/multiple_movies.hifi_reads.fastq

OUTPUT=/mnt/parscratch/users/bop24erb/Marram/Marram_PopData/Data/ReferenceGenome/hifiasm

mkdir -p $OUTPUT

# Run hifiasm
hifiasm \
    -o $OUTPUT/marram \
    -t 32 \
    $READS
