#!/bin/bash
#SBATCH --job-name=plink_fst_marram_239
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
module load PLINK/2.00a3.7-foss-2022a

## Requires plink input files: marram.bed, marram.bim, marram.fam


plink2 \
	--bfile marram_239 \
	--fst CATPHENO method=hudson \
	--within marram.pop.txt \
	--double-id \
	--allow-extra-chr \
	--out pairwise_fst_marram