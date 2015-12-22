library(org.Hs.eg.db)

# Get the entrez gene identifiers that are mapped to any RefSeq ID
x <- org.Hs.egREFSEQ
mapped_genes <- mappedkeys(x)

# Convert to a dataframe
yy <- as.data.frame(x[mapped_genes])

# Output entrez gene vs RefSeq ID data
output_file <- "C:/Users/Naoto/Documents/github/CFIm25_study/2015-12-22_pathway_analysis/result/Entrez_ID_vs_RefSeq_ID.txt"
write.table(yy, file=output_file, sep="\t", row.names=FALSE)

# Check keytypes
keytypes(org.Hs.eg.db)

# Check how to get information from Entrez ID
res <- select(org.Hs.eg.db,
              keys = "NM_004239",
              keytype = "REFSEQ",
              columns = c("SYMBOL", "GENENAME", "REFSEQ", "ENTREZID", "GO", "PATH"))

# Load your symbol data
library(data.table)
input_file <- "C:/Users/Naoto/Documents/github/CFIm25_study/2015-12-22_pathway_analysis/raw_data/gene_exp_RefSeq_result_mRNA.diff"
symbol_data <- fread(input_file, header=T)[[2]]

# Get entrez ID from gene symbol
res <- select(org.Hs.eg.db,
              keys = symbol_data,
              keytype = "SYMBOL",
              columns = c("SYMBOL", "GENENAME", "ENTREZID"))
#res <- select(org.Hs.eg.db,
#              keys = symbol_data,
#              keytype = "SYMBOL",
#              columns = c("SYMBOL", "GENENAME", "REFSEQ", "ENTREZID"))

# Output entrez gene vs gene symbol data
output_file <- "C:/Users/Naoto/Documents/github/CFIm25_study/2015-12-22_pathway_analysis/result/Entrez_ID_vs_gene_symbol.txt"
write.table(res, file=output_file, sep="\t", row.names=FALSE)
