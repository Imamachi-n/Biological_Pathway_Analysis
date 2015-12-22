#!/usr/bin/env python3

import sys

entrez_id_file = open(sys.argv[1], 'r')
input_file = open(sys.argv[2], 'r')
output_file = open(sys.argv[3], 'w')

entrez_id_dict = {}

for line in entrez_id_file:
    line = line.rstrip()
    line = line.replace('"','')
    data = line.split("\t")
    if data[0] == 'SYMBOL':
        continue
    symbol = data[0]
    detail = data[1]
    entrez_id = data[2]
    if not symbol in entrez_id_dict:
        entrez_id_dict[symbol] = [detail,entrez_id]
    else:
        print("Before: ",entrez_id_dict[symbol])
        print("After: ",detail, entrez_id)

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    if data[0] == "gr_id":
        print("gr_id","symbol","accession_id","Entrez_ID","log2_FC","significant",sep="\t",file=output_file)
        continue
    gr_id = data[0]
    symbol = data[1]
    accession_id = data[2]
    log2_FC = data[7]
    if log2_FC == "-inf" or log2_FC == "inf":
        #log2_FC = "0"
        continue
    significant = data[10]
    if symbol in entrez_id_dict:
        infor = entrez_id_dict[symbol]
        detail = infor[0]
        entrez_id = infor[1]
        if entrez_id == "NA":
            continue
        print(gr_id,symbol,accession_id,entrez_id,log2_FC,significant, sep="\t",file=output_file)
    else:
        #print(gr_id,symbol,accession_id,"NA",log2_FC,significant, sep="\t",file=output_file)
        pass
