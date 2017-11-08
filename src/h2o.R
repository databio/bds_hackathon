
folder = "/sfs/lustre/allocations/bds_tg/citeseq/processed_data"
genesFile = paste0(folder, "/human_sub.csv.gz")
adtFile = paste0(folder, "/CBMC_ADT_clr_filtered.csv")
genesDat = data.table::fread((paste0("zcat ", genesFile)))
adtDat = data.table::fread(adtFile)



# we need the columns to be features, and rows cells. so transpose.

targetCols = adtDat[,1]$V1
geneCols = genesDat[,1]$V1
adtDat = t(adtDat[,-1])
genesDat = t(genesDat[,-1])

colnames(adtDat) = targetCols
colnames(genesDat) = geneCols

y = targetCols
x = geneCols

allDat = cbind(genesDat, adtDat)
tfFile = paste0(folder, "/training_frame.tsv")
write.tsv(tfFile, allDat)

scrna.hex = h2o.uploadFile(tfFile, destination_frame="scrna")
summary(scrna.hex)
dl_fit1 <- h2o::h2o.deeplearning(x = x,
                            y = y,
                            training_frame = allDat,
                            model_id = "dl_fit1",
                            hidden = c(20,20),
                            seed = 1)