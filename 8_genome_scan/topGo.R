## TopGO gene ontology enrichment
library(topGO)

setwd("/Users/bi1ecu/Library/CloudStorage/GoogleDrive-emma.curran@sheffield.ac.uk/My Drive/Marram/pop_gen/pcadapt/")

# Load universe + candidate genes
geneUniverse <- scan("gene_universe_list_50kb.txt", what="")
sigGenes <- scan("gene_candidate_list_50kb.txt", what="")

# Build binary vector
geneList <- factor(as.integer(geneUniverse %in% sigGenes))
names(geneList) <- geneUniverse

# Load GO mapping
geneID2GO <- readMappings("marram_gene2go_ath_ory.map")




## Molecular Function
GOdata_MF <- new("topGOdata",ontology="MF",allGenes=geneList,
                 annot=annFUN.gene2GO,gene2GO=geneID2GO)
test.stat <- new("classicCount", testStatistic = GOFisherTest, name = "Fisher test")
resultFisher <- getSigGroups(GOdata_MF, test.stat)
test.stat2 <- new("weightCount", testStatistic = GOFisherTest, name = "Fisher test", sigRatio = "ratio")
resultWeight <- getSigGroups(GOdata_MF, test.stat2)
allRes <- GenTable(GOdata_MF, classic = resultFisher, 
                   weight = resultWeight, orderBy = "weight", 
                   ranksOf = "classic",topNodes=length(resultFisher@score),numChar=100)


filtRes.MF <- allRes[allRes$classic<0.05 & allRes$Significant>2,]
filtRes.MF$Ontology <- "MF"


## Biological Process
GOdata_BP <- new("topGOdata",ontology="BP",allGenes=geneList,
                 annot=annFUN.gene2GO,gene2GO=geneID2GO)
resultFisher <- getSigGroups(GOdata_BP, test.stat)
resultWeight <- getSigGroups(GOdata_BP, test.stat2)
allRes <- GenTable(GOdata_BP, classic = resultFisher, 
                   weight = resultWeight, orderBy = "weight", 
                   ranksOf = "classic",topNodes=length(resultFisher@score),numChar=100)
filtRes.BP <- allRes[allRes$classic<0.05 & allRes$Significant>2,]
filtRes.BP$Ontology <- "BP"

##Cellular Component
GOdata_CC <- new("topGOdata",ontology="CC",allGenes=geneList,
                 annot=annFUN.gene2GO,gene2GO=geneID2GO)
resultFisher <- getSigGroups(GOdata_CC, test.stat)
resultWeight <- getSigGroups(GOdata_CC, test.stat2)
allRes <- GenTable(GOdata_CC, classic = resultFisher, 
                   weight = resultWeight, orderBy = "weight", 
                   ranksOf = "classic", topNodes=length(resultFisher@score))
filtRes.CC <- allRes[allRes$classic<0.05 & allRes$Significant>2,]
filtRes.CC$Ontology <- "CC"

##Output all three
filt.all <- rbind(filtRes.BP,filtRes.MF,filtRes.CC)
write.csv(filt.all,"pcadapt_cands_50kbwin_GOenrichment.csv")
