###Gene_ontology_analysis###
library(gage)
library(gageData)
data(go.sets.hs)
data(go.subs.hs)
gobpsets = go.sets.hs[go.subs.hs$BP]

# Prepare entrez ID | log2_FC data
library(data.table)
input_path <- "C:/Users/Naoto/Documents/github/CFIm25_study/2015-12-22_pathway_analysis/result/gene_exp_RefSeq_result_mRNA_entrez_ID.txt"
input_file <- fread(input_path, header=T)

# Extract DEG genes
DEG_file <- input_file[significant == "yes"]
DEG_file <- transform(DEG_file,log2_FC = as.numeric(log2_FC))
DEG_file <- DEG_file[log2_FC > 0]

foldchanges = DEG_file$log2_FC
names(foldchanges) = DEG_file$Entrez_ID

gobpres = gage(foldchanges, gsets=gobpsets, same.dir=TRUE)

lapply(gobpres, head)
test <- as.data.frame(gobpres)

output_file <- "C:/Users/Naoto/Documents/github/CFIm25_study/2015-12-22_pathway_analysis/result/GO_enrichment_analysis_result.txt"
write.table(test, file=output_file, sep="\t", row.names=TRUE)
