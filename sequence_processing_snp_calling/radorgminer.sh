#!/bin/bash
#SBATCH --job-name=radorgminer_masking
#SBATCH --time=96:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=8
#SBATCH --output=%x.%A.out
#SBATCH --error=%x.%A.error

source ~/.bashrc
conda activate radorgminer-env

ROM="/users/bi1ecu/software/RADOrgMiner_OG/RADOrgMiner/RADOrgMiner.sh"
ref="/mnt/parscratch/users/bi1ecu/organelle_assembly/marram.pltd.ctg.fasta"
seqdir="/mnt/parscratch/users/bi1ecu/sequences/filtered/unique_fastq/filt"
outdir="/mnt/parscratch/users/bi1ecu/radorgminer/out_masking"

# step one: alignments (with masking switched on)
$ROM --mask-reference yes -r $ref -align yes -call no -popmap popmap2.txt -s $seqdir -o $outdir -np 8 -type PE 


# step two: call haplotypes

#$ROM --mask-reference yes -r $ref -align no -call yes -minbc 15 -o $outdir -miss 0.98 -np 8 -popmap popmap.txt -type PE