#!/bin/bash
###Requisite###
##Software/Scripts##
#Get_Entrez_ID_from_Gene_Symbol.R
#Merge_Entrez_ID_with_RNA-seq_result.py

##dataset##
#Get_Entrez_ID_from_Gene_Symbol.R
#Merge_Entrez_ID_with_RNA-seq_result.py

###File PATH###
RNAseqResult=${1} #'gene_exp_RefSeq_result_mRNA.diff'


###Get Entrez ID from gene symbol###
#Rscript Get_Entrez_ID_from_Gene_Symbol.R

###Merge RNA-seq result with Entrez ID###
#filename=`basename ${RNAseqResult} .diff`
#python3 ./scripts/Merge_Entrez_ID_with_RNA-seq_result.py Entrez_ID_vs_gene_symbol.txt ${filename}.diff ${filename}_entrez_ID.txt
