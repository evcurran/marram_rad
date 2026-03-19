# Marram grass population genomics

Scripts used for data analysis in the following manuscript:

**Population structure, local adaptation and gene family expansion in marram grass**


## 1. Genome assembly and annotation
* Assemble reads
* Annotate assembly with Helixer
* [Assemble organellar genomes](./1_genome_assembly/oatk.sh) 

## 2. Gene family expansions and contractions

## 3. Read processing and alignment
* [Filter and trim reads](./3_read_processing_alignment/sequence_trimming_filtering_fastp.sh)
* [Detect organellar SNPs](./3_read_processing_alignment/radorgminer.sh)
* [Align reads to assembly](./3_read_processing_alignment/bwamem2.sh)  

## 4. Population structure
* [Genotype likelihoods estimated with ANGSD](./4_population_structure/gen_beagle.sh)
* [PCA of genetic variation](./4_population_structure/pcangsd.sh)
* [Admixture proportions estimated](./4_population_structure/ngsadmix.py)
  
## 5. Isolation-by-distance
* [Call SNPs](./5_isolation_by_distance/bcftools_call_filt.sh)
* [Pairwise F<sub>ST</sub> estimation](./5_isolation_by_distance/pairwise_fst.sh)
* [Mantel test for IBD](5_isolation_by_distance/IBD_test.R)

## 6. Phylogenetic tree
* [Tree constructed with RAxML](./6_phylogenetic_tree/raxml.sh)

## 7. Genetic diversity
* [Downsample populations](./7_genetic_diversity/subsample_pops.sh)
* [Estimate 𝛑 and Tajima’s D](./7_genetic_diversity/pixy.sh)

## 8. Genome scan for local adaptation
* [PCA-based genome scan](./8_genome_scan/pcadapt.R)
* Gene ontology enrichment analysis:
    1. [Functionally annotate genes](./8_genome_scan/blastp_oryza_thaliana.sh)
    2. [Download UniProt GO terms](./8_genome_scan/download_uniprot_go_terms.sh)
    3. [Generate input files for topGO](./8_genome_scan/topgo_input_files.sh) (candidate gene list, 'gene universe' list and marram annotation-to-GO term map)
    4. Run topGO analysis
   
   
