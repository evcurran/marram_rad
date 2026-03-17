#!/bin/bash
#SBATCH --job-name=pcangsd_marram
#SBATCH --time=8:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=8
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
mamba activate angsd_env

# beagle genotype likelihoods file generated using gen_beagle.sh script
beagle="/mnt/parscratch/users/bi1ecu/pop_structure/beagle/marram.beagle.gz"


pcangsd --beagle $beagle --iter 1000 --eig 0 --maf 0.0 --threads 8 --out marram --admix