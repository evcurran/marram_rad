#!/bin/bash
#SBATCH --job-name=oatk
#SBATCH --time=96:00:00
#SBATCH --mem=500G
#SBATCH --cpus-per-task=8
#SBATCH --output=%x.%A.out
#SBATCH --error=%x.%A.error

source ~/.bashrc
mamba activate chloro_asm
hifi="/mnt/parscratch/users/bi1ecu/sequences/hifi/multiple_movies.hifi_reads.fastq.gz"

oatk -k 1001 -c 350 -t 8 --nhmmscan /users/bi1ecu/miniforge3/envs/chloro_asm/bin/nhmmscan \
-m /users/bi1ecu/software/OatkDB/v20230921/embryophyta_mito.fam \
-p /users/bi1ecu/software/OatkDB/v20230921/embryophyta_pltd.fam \
-o marram $hifi