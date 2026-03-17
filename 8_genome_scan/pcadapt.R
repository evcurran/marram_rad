library(pcadapt)
library(vcfR)
library(qvalue)
library(dplyr)
setwd("/Users/bi1ecu/Documents/github_repos/marram_rad/genome_scan")

# read in files
path_to_file <- "/Users/bi1ecu/Documents/github_repos/marram_rad/genome_scan/marram_pcadapt.bed"
filename <- read.pcadapt(path_to_file, type = "bed")


# use scree plot to select value of k (as in https://bcm-uga.github.io/pcadapt/articles/pcadapt.html)
x <- pcadapt(input = filename, K = 20) 

pdf("screeplot_pcadapt.pdf", height=5, width=8, useDingbats=F)
plot(x, option = "screeplot")
dev.off()


# selected value of k=7
x <- pcadapt(input = filename, K = 7)

plot(x , option = "manhattan")
plot(x , option = "qqplot")


# Accounting for FDR
qval <- qvalue(x$pvalues)$qvalues
alpha <- 0.05
outliers <- which(qval < alpha)
length(outliers)
snp_pc <- get.pc(x, outliers)


# Summarise the outlier data next to SNP ids.
snpIDs <- read.table("marram_rad_noPT_noSTU_SNP_list.txt")
colnames(snpIDs) <- c("chrom", "pos", "ref", "alt")
pvals <- as.data.frame(x$pvalues)
colnames(pvals) <- "pvals"
snps <- cbind(snpIDs, pvals)
snps$index <- seq_len(nrow(snps))
snps$significant <- ifelse(snps$index %in% outliers, "Y", "N")
sigsnp <- filter(snps, significant=="Y")

significant_snps_bed <- data.frame(sigsnp$chrom, (sigsnp$pos)-1, sigsnp$pos)
significant_snps_bed$new_column <- "."

# output significant SNP positions
write.table(significant_snps_bed, file = "significant_snps.txt", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)



pdf("manahattan_plot.pdf", height=5, width=8, useDingbats=F)
plot(snps$index, -log10(snps$pvals),
     xlab="SNP (with MAF>0.05)",
     ylab="Observed -log10(p-value)",
     pch=16,
     col = ifelse(snps$significant=="Y",'red', 'black'))
dev.off()


