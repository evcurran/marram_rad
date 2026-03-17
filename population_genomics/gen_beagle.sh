#!/bin/bash
#SBATCH --job-name=gen_beagle
#SBATCH --time=48:00:00
#SBATCH --mem=100G
#SBATCH --cpus-per-task=16
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
mamba activate angsd_env

bams="/mnt/parscratch/users/bi1ecu/pop_structure/beagle/bamlist.txt"


angsd -bam $bams -nThreads 16 -GL 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -minMapQ 20 -minQ 20 -minInd 120 -doCounts 1 -setMinDepthInd 5 -doGlf 2 -out marram -P 1