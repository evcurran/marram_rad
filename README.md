# Marram grass population genomics

Scripts used for data analysis in the following manuscript:

**Population structure, local adaptation and gene family expansion in marram grass**

Sections include: 

1. **Genome assembly and annotation**
   * Assemble reads with hifiasm
   * Annotate assembly with Helixer
     
3. **Gene family expansions and contractions**
4. **Read processing and alignment**
   * Filter and trim reads with fastp
   * Align reads to assembly with bwa-mem2
5. **Population structure**
   * Genotype likelihoods estimated with ANGSD
   * PCA of genetic variation with PCAngsd
   * Admixture proportions estimated with ngsadmix
6. **Isolation-by-distance**
   * SNP calls with bcftools
   * Pairwise F<sub>ST</sub> estimation with plink
   * Mantel test in R
7. **Phylogenetic tree**
   * Tree constructed with RAxML
8. **Genetic diversity**
    * 𝛑 and Tajima’s D estimated with pixy
    * F<sub>IS</sub> estimated with ANGSD

9. **Genome scan for local adaptation**
   * PCA-based genome scan with pcadapt R package
   * Gene ontology enrichment analysis:
     1. Functionally annotate genes
     2. Generate input files for topGO (candidate gene list, 'gene universe' list and marram annotation-to-GO term map)
     3. Run topGO analysis
   
   
