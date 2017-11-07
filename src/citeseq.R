projectInit("bds_hackathon")
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

ngenes = apply(datam > 0, 2, sum)
pdf(dirOut("ngenes.pdf"))
plot(ngenes)
dev.off()

# Grab a vector indexing all human genes
humanGenes = genes[,grepl("HUMAN_", V1)]

humanGenes

hCount = apply(datam[humanGenes,] > 0, 2, sum)
mCount = apply(datam[!humanGenes,] > 0, 2, sum)

# How many of the cells are human?
sum(hCount > mCount)/ ncol(datam)

# which cells are human
humanCells = hCount > mCount
datah = datam[humanGenes, humanCells, with=FALSE]
datah

ngenes = apply(datah > 0, 2, sum)
pdf(dirOut("ngenesh.pdf"))
plot(ngenes)
dev.off()


rm(d)

# Read in ADT data
# this will be our target
infile = paste0(folder, "GSE100866_CBMC_8K_13AB_10X-ADT_umi.csv.gz")
dADT = data.table::fread((paste0("zcat ", infile)))
dim(dADT)
dADTab = dADT[,1]
dADTd = dADT[,-1]

# colnames match? yes.
all(colnames(dADT) == colnames(d))

# Restrict to human only
dADTHuman = dADTd[, humanCells, with=FALSE]
dim(dADTHuman)
dim(datah)
all(colnames(datah) == colnames(dADTHuman))

# Merge
combinedHuman = rbind(datah, dADTHuman)
combinedRownames = rbind(genes[humanGenes], dADTab)

annotatedData = cbind(combinedRownames, combinedHuman)

annotatedData = t(annotatedData)

write.tsv(annotatedData, "annotatedData.tsv")
library(h2o)
h2o.init(max_mem="16G")

infile="annotatedData.tsv"
scrna.hex = h2o.uploadFile(infile, destination_frame="scrna")
summary(scrna.hex)

dl_fit1 <- h2o.deeplearning(x = x,
                            y = y,
                            training_frame = annotatedData,
                            model_id = "dl_fit1",
                            hidden = c(20,20),
                            seed = 1)