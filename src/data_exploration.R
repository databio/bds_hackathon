#install.packages('ltm')
#library('ltm')
options(BDSDATA = "/sfs/lustre/allocations/bds_tg/")
dataDir = paste0(getOption("BDSDATA"), "citeseq/")

CBMC_rna = read.csv(paste0(dataDir,"GSE100866_CBMC_8K_13AB_10X-RNA_umi.csv"), stringsAsFactors = F, as.is = T, row.names = 1)
CBMC_ADT = read.csv(paste0(dataDir,"GSE100866_CBMC_8K_13AB_10X-ADT_umi.csv"), stringsAsFactors = F, as.is = T, row.names = 1)




# length(grep("mouse",CBMC_rna$X, ignore.case = T))
# #15879 mouse genes
# 
# length(grep("human",CBMC_rna$X, ignore.case = T))
# #20400 human genes
# 
# grep("HUMAN_CBMCA",CBMC_rna$X, ignore.case = T)
# grep("HUMAN_CBMCB",CBMC_rna$X, ignore.case = T)
# 
# x = cor.test(unlist(CBMC_ADT[3,2:8618]), unlist(CBMC_rna[grep("HUMAN_CBMCB",CBMC_rna$X, ignore.case = T),2:8618]))
# 
# #cells with spike-in >0
# names(which((unlist(CBMC_rna[1,2:8618]))>0))
# 
# summary(CBMC_rna[,124])
# summary(CBMC_rna[,123])
# 
# x = apply(CBMC_rna, 2, function(x) max(x))
# plot(x)
# y = apply(CBMC_rna, 2, function(x) sum(x>1))
# plot(y)


######### START HERE #############
#gene indices of mice
mouse_gene_idx = grep("mouse",rownames(CBMC_rna), ignore.case = T)

#gene indices of human
human_gene_idx = grep("human",rownames(CBMC_rna), ignore.case = T)

#sum counts of mouse genes
mouse_sums = apply(CBMC_rna, 2, function(x) sum(x[mouse_gene_idx]))

#sum counts of human genes
human_sums = apply(CBMC_rna, 2, function(x) sum(x[human_gene_idx]))

#dataframe of mouse and human sums. Rows are cells
mouse_human_sums = as.data.frame(cbind(mouse_sums,human_sums))

#add column for ratio of human counts to total counts, per cell
mouse_human_sums$pct_human = mouse_human_sums$human_sums / (mouse_human_sums$mouse_sums + mouse_human_sums$human_sums)

#add logical columns to classify cells as mouse or human, based on criteria in paper
mouse_human_sums$human_class = mouse_human_sums$pct_human >= 0.9
mouse_human_sums$mouse_class = mouse_human_sums$pct_human <= 0.1

#add color column. red if human, black otherwise
mouse_human_sums$color = ifelse(mouse_human_sums$human_class,"red","black")
plot(x,col=mouse_human_sums$color)

#create a dataframe for humans, based on classification
human = CBMC_rna[,which(mouse_human_sums$human_class)]

#remove mouse genes
human = human[human_gene_idx,]

#length(which(mouse_human_sums$human_class)) / nrow(mouse_human_sums)
