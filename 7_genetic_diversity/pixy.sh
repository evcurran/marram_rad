#!/bin/bash
#SBATCH --job-name=pixy_run_n7_max_missing_0.2_win500k
#SBATCH --time=8:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
mamba activate pixy_env

vcf="/mnt/parscratch/users/bi1ecu/pop_structure/pixy/downsampling/marram_subsampled_n7_dp_miss0.2.vcf.gz"
popfile="/mnt/parscratch/users/bi1ecu/pop_structure/pixy/downsampling/pixy_popfile_n7.txt"
outdir="/mnt/parscratch/users/bi1ecu/pop_structure/pixy/downsampling/n7_max_missing_0.2_win500k"


mkdir $outdir

pixy --stats pi fst dxy tajima_d --fst_type hudson --vcf $vcf --populations $popfile --window_size 500000 --n_cores 8 --output_folder $outdir 