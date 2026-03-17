#!/bin/bash
#SBATCH --job-name=bwa-mem2_array
#SBATCH --time=96:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=4
#SBATCH --output=%j.%A_%a.out
#SBATCH --error=%j.%A_%a.error
#SBATCH --array=0-274

source ~/.bashrc
mamba activate radseq_env
module load SAMtools/1.16.1-GCC-11.3.0

indir="/mnt/parscratch/users/bi1ecu/radorgminer/out_masking/unaligned"
outdir="/mnt/parscratch/users/bi1ecu/alignments/marram_rad_romUnal"
bwamem2="/users/bi1ecu/software/bwa-mem2-2.2.1_x64-linux/bwa-mem2"
ref="/mnt/parscratch/users/bi1ecu/refs/hifiasm_26858_2G_nhap_4.bp.p_ctg.fasta"

files=($(cat ${outdir}/samples))
file="${files[$SLURM_ARRAY_TASK_ID]}"


$bwamem2 mem -t 4 $ref ${indir}/${file}.1.fq.gz ${indir}/${file}.2.fq.gz | samtools view -b | samtools sort -T ${file} > ${outdir}/${file}.sorted.bam


samtools flagstat ${outdir}/${file}.sorted.bam > ${outdir}/${file}.sorted.bam.flagstat.txt


