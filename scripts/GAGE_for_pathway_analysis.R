library(pathview)
library(gage)
library(gageData)
data(kegg.sets.hs)
#data(sigmet.idx.hs)
#kegg.sets.hs = kegg.sets.hs[sigmet.idx.hs]

# Prepare entrez ID | log2_FC data
library(data.table)
input_path <- "C:/Users/Naoto/Documents/github/CFIm25_study/2015-12-22_pathway_analysis/result/gene_exp_RefSeq_result_mRNA_entrez_ID.txt"
input_file <- fread(input_path, header=T)

# Extract DEG genes
DEG_file <- input_file[significant == "yes"]
DEG_file <- transform(DEG_file,log2_FC = as.numeric(log2_FC))
#DEG_file <- DEG_file[log2_FC > 0]

foldchanges = DEG_file$log2_FC
names(foldchanges) = DEG_file$Entrez_ID

keggres = gage(foldchanges, gsets=kegg.sets.hs, same.dir=TRUE)

# Check the result 
lapply(keggres, head)

#up-regulated pathways visualized by pathview
sel <- keggres$greater[, "p.val"] < 0.20
keggresids <- rownames(keggres$greater)[sel]
keggresids <- substr(keggresids, start=1, stop=8)
keggresids <- path.ids[!is.na(keggresids)]
#keggresids <- c("hsa04210")
plot_pathway = function(pid) pathview(gene.data=foldchanges, pathway.id=pid, species="hsa", new.signature=FALSE)

tmp = sapply(keggresids, function(pid) pathview(gene.data=foldchanges, pathway.id=pid, species="hsa"))

