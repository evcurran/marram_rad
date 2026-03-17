#!/bin/bash
#SBATCH --job-name=fastp_array
#SBATCH --mem=64G
#SBATCH --cpus-per-task=4
#SBATCH --output=fastp_array.%A_%a.out
#SBATCH --error=fastp_array.%A_%a.error
#SBATCH --array=0-275

source ~/.bashrc
mamba activate radseq_env


indir="/mnt/parscratch/users/bi1ecu/sequences/filtered/unique_fastq"
outdir="/mnt/parscratch/users/bi1ecu/sequences/filtered/unique_fastq/filt"

files=($(cat /mnt/parscratch/users/bi1ecu/sequences/filtered/unique_fastq/samples.txt))
file="${files[$SLURM_ARRAY_TASK_ID]}"


# with filtering - prior to merging fastq
fastp -i ${indir}/${file}.1.fq.gz -I ${indir}/${file}.2.fq.gz -o ${outdir}/${file}.filt.1.fq.gz -O ${outdir}/${file}.filt.2.fq.gz -h ${outdir}/${file}.html -j ${outdir}/${file}.json -q 20 --dont_eval_duplication -w 4