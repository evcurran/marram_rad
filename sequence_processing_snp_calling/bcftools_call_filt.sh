#!/bin/bash
#SBATCH --job-name=bcftools_call_filt
#SBATCH --time=96:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=16
#SBATCH --output=%j.%A.out
#SBATCH --error=%j.%A.error

source ~/.bashrc
mamba activate radseq_env
module load BCFtools/1.15.1-GCC-11.3.0

ref="/mnt/parscratch/users/bi1ecu/refs/hifiasm_26858_2G_nhap_4.bp.p_ctg.fasta"
outdir="/mnt/parscratch/users/bi1ecu/snp_calling/marram_rad"
bamlist="/mnt/parscratch/users/bi1ecu/snp_calling/marram_rad/bamlist"


# call SNPs
bcftools mpileup -a AD,DP,SP -Ou -f $ref -b $bamlist --threads 4 | bcftools call -f GQ,GP --threads 16 -m -Oz -o ${outdir}/marram_rad_all.vcf.gz 


# filter VCF
bcftools view --threads 16 -S $bamlist -i 'QUAL>=20' --types snps -m 2 -M 2 -Ou ${outdir}/marram_rad_all.vcf.gz | \
  bcftools filter --threads 16 -S . -e 'FMT/DP<5' -Ou | \
  bcftools view --threads 16 -i 'F_MISSING<=0.2' -Oz \
  -o ${outdir}/marram_rad_all_q20_mindp5_miss0.2.vcf.gz