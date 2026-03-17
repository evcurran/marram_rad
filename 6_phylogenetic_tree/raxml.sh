#!/bin/bash
#SBATCH --job-name=raxml_239
#SBATCH --time=96:00:00
#SBATCH --mem=120G
#SBATCH --cpus-per-task=16
#SBATCH --output=%j.%A.out
#SBATCH --error=%j.%A.error

source ~/.bashrc
mamba activate raxml_env


raxmlHPC-PTHREADS -s marram_full_set_rm375.phy -n marram_nuc_tree_239_GTR.raxml.out -m GTRCAT -f a -x $RANDOM -# 100 -p $RANDOM -T 16