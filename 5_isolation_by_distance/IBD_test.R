# Mantel test for IBD
library(tidyverse)
library(vegan)
library(ape)
library(geosphere)

setwd("/Users/bi1ecu/Library/CloudStorage/GoogleDrive-emma.curran@sheffield.ac.uk/My Drive/Marram/pop_gen/fst")


## Create Fst distance matrix ##

fst_data <- read.table("pairwise_fst_marram.fst.summary.txt", header = T) # this is the output from plink

# Get all unique population names
populations <- unique(c(fst_data$POP1, fst_data$POP2))

# Create an empty distance matrix
fst_matrix <- matrix(NA, nrow=length(populations), ncol=length(populations),
                     dimnames=list(populations, populations))

# Fill the matrix
for (i in 1:nrow(fst_data)) {
  p1 <- fst_data$POP1[i]
  p2 <- fst_data$POP2[i]
  val <- fst_data$HUDSON_FST[i]
  fst_matrix[p1, p2] <- val
  fst_matrix[p2, p1] <- val  # Symmetric
}

# Set diagonal to 0 (FST with self = 0)
diag(fst_matrix) <- 0

# Convert to dist object 
fst_dist <- as.dist(fst_matrix)

## Create geographic distance matrix ##
geo_df <- read.csv("25_07_22_Initial_Fst_Coords.csv")
coord_matrix <- as.matrix(geo_df[, c("Longitude", "Latitude")])
rownames(coord_matrix) <- geo_df$Population
geo_dist <- distm(coord_matrix, fun = distHaversine)
geo_dist_matrix <- as.dist(geo_dist)
geo_dist_matrix <- geo_dist_matrix/1000

rownames(geo_dist) <- colnames(geo_dist) <- geo_df$Population
geo_df_long <- as.data.frame(as.table(geo_dist))
colnames(geo_df_long) <- c("POP1", "POP2", "km")

# convert meters to kilometers
geo_df_long$km <- geo_df_long$km / 1000

# remove self-comparisons
geo_df_long <- geo_df_long[geo_df_long$POP1 != geo_df_long$POP2, ]

# keep each pair only once

geo_df_long <- geo_df_long[as.character(geo_df_long$POP1) <
                             as.character(geo_df_long$POP2), ]
write.table(geo_df_long, "pairwise_pop_distance_km.txt", quote = F, row.names = F)

## Mantel test for IBD ##
fst_geo  = mantel(fst_dist, geo_dist_matrix, method = "spearman", permutations = 9999, na.rm = TRUE)


# Extract values from distance matrixes 
fst_values <- as.vector(fst_dist)
geo_values <- as.vector(geo_dist_matrix)

# Create scatter plot

pdf(paste0("ibd_plot_239.pdf"), height=3, width=6, useDingbats=F)
plot(geo_values, fst_values,
     xlab = "Pairwise geographic distance (km)",
     ylab = expression("Pairwise F"[ST]),
     pch = 19)
dev.off()



#### within subspecies mantel test ####

# WITHIN GEO
wi_sub_geo <- read.table("pairwise_pop_distance_km_within_subspecies.txt", header=T)
# Get all unique population names
populations <- unique(c(wi_sub_geo$POP1, wi_sub_geo$POP2))
# Create an empty distance matrix
geo_matrix_wi <- matrix(NA, nrow=length(populations), ncol=length(populations),
                        dimnames=list(populations, populations))
# Fill the matrix
for (i in 1:nrow(wi_sub_geo)) {
  p1 <- wi_sub_geo$POP1[i]
  p2 <- wi_sub_geo$POP2[i]
  val <- wi_sub_geo$km[i]
  geo_matrix_wi[p1, p2] <- val
  geo_matrix_wi[p2, p1] <- val  # Symmetric
}
# Set diagonal to 0 (FST with self = 0)
diag(geo_matrix_wi) <- 0
# Convert to dist object 
geo_dist_wi <- as.dist(geo_matrix_wi)


# WITHIN FST
wi_sub_fst <- read.table("pairwise_fst_marram_within_subspecies.txt", header = T)

# Create an empty distance matrix
fst_matrix_wi <- matrix(NA, nrow=length(populations), ncol=length(populations),
                     dimnames=list(populations, populations))
# Fill the matrix
for (i in 1:nrow(wi_sub_fst)) {
  p1 <- wi_sub_fst$POP1[i]
  p2 <- wi_sub_fst$POP2[i]
  val <- wi_sub_fst$HUDSON_FST[i]
  fst_matrix_wi[p1, p2] <- val
  fst_matrix_wi[p2, p1] <- val  # Symmetric
}
# Set diagonal to 0 (FST with self = 0)
diag(fst_matrix_wi) <- 0
# Convert to dist object 
fst_dist_wi <- as.dist(fst_matrix_wi)

# Mantel test
fst_geo_wi  = mantel(fst_dist_wi, geo_dist_wi, method = "spearman", permutations = 9999, na.rm = TRUE)


#### between subspecies mantel test ####

# BETWEEN GEO
bw_sub_geo <- read.table("pairwise_pop_distance_km_between_subspecies.txt", header=T)
# Get all unique population names
populations <- unique(c(bw_sub_geo$POP1, bw_sub_geo$POP2))
# Create an empty distance matrix
geo_matrix_bw <- matrix(NA, nrow=length(populations), ncol=length(populations),
                        dimnames=list(populations, populations))
# Fill the matrix
for (i in 1:nrow(bw_sub_geo)) {
  p1 <- bw_sub_geo$POP1[i]
  p2 <- bw_sub_geo$POP2[i]
  val <- bw_sub_geo$km[i]
  geo_matrix_bw[p1, p2] <- val
  geo_matrix_bw[p2, p1] <- val  # Symmetric
}
# Set diagonal to 0 (FST with self = 0)
diag(geo_matrix_bw) <- 0
# Convert to dist object 
geo_dist_bw <- as.dist(geo_matrix_bw)


# BETWEEN FST
bw_sub_fst <- read.table("pairwise_fst_marram_between_subspecies.txt", header = T)

# Create an empty distance matrix
fst_matrix_bw <- matrix(NA, nrow=length(populations), ncol=length(populations),
                        dimnames=list(populations, populations))
# Fill the matrix
for (i in 1:nrow(bw_sub_fst)) {
  p1 <- bw_sub_fst$POP1[i]
  p2 <- bw_sub_fst$POP2[i]
  val <- bw_sub_fst$HUDSON_FST[i]
  fst_matrix_bw[p1, p2] <- val
  fst_matrix_bw[p2, p1] <- val  # Symmetric
}
# Set diagonal to 0 (FST with self = 0)
diag(fst_matrix_bw) <- 0
# Convert to dist object 
fst_dist_bw <- as.dist(fst_matrix_bw)

# Mantel test
fst_geo_bw  = mantel(fst_dist_bw, geo_dist_bw, method = "spearman", permutations = 9999, na.rm = TRUE)

