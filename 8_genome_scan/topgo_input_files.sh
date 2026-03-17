#!/bin/bash
#SBATCH --job-name=topgo_gen_input
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --output=%x.out
#SBATCH --error=%x.error

source ~/.bashrc
module load BEDTools/2.31.0-GCC-12.3.0
module load PLINK/2.00a3.7-foss-2022a

# input: vcf that was used for the genome scan, list of significant SNPs from the genome scan.

VCF="/mnt/parscratch/users/bi1ecu/snp_calling/marram_rad/marram_rad_all_bams_q20_mindp5_miss0.2_pcadapt2.vcf.gz"
SIG_SNP="significant_snps.txt"
PREFIX="marram_pcadapt"
GFF="/mnt/parscratch/users/bi1ecu/refs/marram_annotation.gff3"


plink --vcf $VCF --allow-extra-chr --double-id --make-bed --out $PREFIX

# Generate 'gene universe' for topgo - i.e. any gene within prescribed window (e.g. 100kb)
# of SNPs in the final dataset used for genome scan

# Convert all SNPs to BED (this is a positional file and different from the binary .bed produced by plink)
awk '{print $1, $4-1, $4, $2}' OFS="\t" ${PREFIX}.bim > ${PREFIX}_all_snps.bed


# Convert significant SNPs
grep -F -f $SIG_SNP ${PREFIX}.bim | \
awk '{print $1, $4-1, $4, $2}' OFS="\t" > ${PREFIX}_sig_snps.bed


# Overlap SNP windows with annotated genes
bedtools window -a $gff -b ${PREFIX}_all_snps.bed -w 50000 > universe_genes_50kb.bed
bedtools window -a $gff -b ${PREFIX}_sig_snps.bed -w 50000 > candidate_genes_50kb.bed


# extract gene ids from universe_genes.bed and candidate_genes.bed (subsection of gff file)
awk -F'\t' '$3=="gene" {match($9, /ID=([^;]+)/, a); print a[1]}' candidate_genes_50kb.bed | sort -u > gene_candidate_list_50kb.txt
awk -F'\t' '$3=="gene" {match($9, /ID=([^;]+)/, a); print a[1]}' universe_genes_50kb.bed | sort -u > gene_universe_list_50kb.txt


# extract marram uniprot IDs from blast results to get a 'marram genes-to-uniprot' mapping
cut -f1,2 marram_vs_ath_rice.tsv > marram2uniprot_ath_ory.txt
cut -f2 marram2uniprot_ath_ory.txt | sort -u > uniprot_ids_ath_ory.txt


# extract the GO terms for the genes in the thaliana_rice blast db to make a 'uniprot-to-GOterms' mapping
awk 'NR==FNR {ids[$1]; next} ($2 in ids) && $1 !~ /^!/ {print $2, $5}'  uniprot_ids_ath_ory.txt goa_uniprot_all.gaf > uniprot2go_ath_ory.txt


# now input 'uniprot2go_ath_ory.txt' and 'marram2uniprot.txt' into python script to generate marram genes-to-GOterm mappings
python marram_go_mapping.py \
  -u uniprot2go_ath_ory.txt \
  -m marram2uniprot_ath_ory.txt \
  -o marram_gene2go_ath_ory.map


