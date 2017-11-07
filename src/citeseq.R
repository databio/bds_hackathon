projectInit("bds_hm)ackathon")
# if you don't want to use dirOut():
# dirOut = function() { return() }

#dir.create(dirOut(), recursive=TRUE)
folder = "/sfs/lustre/allocations/bds_tg/citeseq/"
list.files(folder)
infile = paste0(folder, "GSE100866_CBMC_8K_13AB_10X-RNA_umi.csv.gz")

d = data.table::fread((paste0("zcat ", infile)))
dim(d)


# [1] "GSE100866_CBMC_8K_13AB_10X-ADT_clr-transformed.csv.gz"
# [2] "GSE100866_CBMC_8K_13AB_10X-ADT_umi.csv.gz"            
# [3] "GSE100866_CBMC_8K_13AB_10X-RNA_umi.csv.gz" 

genes = d[,1]
datam = d[,-1]

# Grab a vector indexing all human genes
humanGenes = genes[,grepl("HUMAN_", V1)]

humanGenes

hCount = apply(datam[humanGenes,] > 0, 2, sum)
mCount = apply(datam[!humanGenes,] > 0, 2, sum)

sum(hCount > mCount)/ ncol(datam)




rm(d)

ngenes = apply(datam > 0, 2, sum)
pdf(dirOut("ngenes.pdf"))
plot(ngenes)
dev.off()

