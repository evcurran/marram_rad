#!/bin/bash
#SBATCH --job-name=plink_input_pcadapt
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
module load PLINK/2.00a3.7-foss-2022a

VCF="/mnt/parscratch/users/bi1ecu/snp_calling/marram_rad/marram_rad_all_bams_q20_mindp5_miss0.2.vcf.gz"

## generates plink input files for pairwise fst estimation

plink --allow-extra-chr \
  --double-id \
  --make-bed \
  --out marram_239 \
  --vcf ${VCF}
