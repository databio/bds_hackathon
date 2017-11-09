options(stringsAsFactors=FALSE)
setwd("/sfs/nfs/blue/ccr5ju/hackathon/data")

#d = read.csv("GSE100866_CBMC_8K_13AB_10X-ADT_clr-transformed.csv.gz", header=TRUE, row.names=1)
#saveRDS(d, file="CBMC_8K_13AB_10X-ADT_clr-transformed.rds")
d = readRDS(file="CBMC_8K_13AB_10X-ADT_clr-transformed.rds")
dt.mat = t(d)
#dt.mat=t(d)[1:100,]
dt.df = as.data.frame(t(d))


#tSNE dimension reduction
#install.packages("tsne")
#library(tsne)
#s = tsne(dt.mat)
s = readRDS("tsne_vectors.txt")

#Barnes Hut approximation
#install.packages("Rtsne")
library(Rtsne)
#bh = Rtsne(dt.mat)
#saveRDS(bh, file="tsne_bh_vectors.rds")
bh=readRDS(file="tsne_bh_vectors.rds")

#principal component analysis
myPCA <- prcomp(dt.mat, scale. = F, center = F)
pcs=myPCA$x # scores

#k means
k=scan(file="../bds_hackathon/results/kmeans/kmeans_10clusters_ADTclr_filtered.csv", sep=",")

##Plots
pdf("cluster_plots.pdf")

#visualize full data set
image(dt.mat)

#look at univariate distributions
for (i in 1:dim(dt.df)[2]){
	marker=names(dt.df)[i]
	hist(dt.df[,i], main=marker)
}

#plot dimension reduction techniques
plot(s[,1],s[,2], main="tSNE (exact) of Surface Markers", xlab="tSNE1", ylab="tSNE2")
plot(bh$Y[,1],bh$Y[,2], main="Barnes-Hut tSNE of Surface Markers", xlab="tSNE1", ylab="tSNE2")
plot(pcs[,"PC1"], pcs[,"PC2"], main="PCA of Surface Markers", xlab="PC1", ylab="PC2")
pairs(pcs[,1:5])


#read in filtered tsnes
library(ggplot2s)
ts=read.table("../bds_hackathon/src/bokeh/tsne_human.txt")
df=data.frame(k, v1=ts$V2, v2=ts$V3)
df$cluster=factor(df$k, levels=seq(0,9,by=1), labels=seq(1,10,by=1))

pdf("cluster_tsne_colored_by_kmeans_ADT.pdf")
ggplot(df, aes(x=v1, y=v2, color=cluster)) + geom_point() + xlab("") + ylab("")

dev.off()

plot(s[,1], s[,2])

##Save data sets
write.table(s, file="ADT+clustering_tsne_coordinates_exact.txt", col.names=FALSE, row.names=row.names(dt.df), quote=FALSE, sep="\t")
write.table(bh$Y, file="ADT+clustering_tsne_coordinates_bh.txt", col.names=FALSE, row.names=row.names(dt.df), quote=FALSE, sep="\t")
write.table(pcs, file="ADT+clustering_principal_components.txt", col.names=TRUE, row.names=TRUE, quote=FALSE, sep="\t")


#Get filtered RNA
rna=read.csv("../bds_hackathon/data/human_sub.csv.gz", header=TRUE, row.names=1)
dim(rna)
head(rna[,1:20])
trna = t(rna)
head(trna[,1:20])
cluster=factor(k, levels=seq(0,9,by=1), labels=seq(1,10,by=1))
df = data.frame(cluster, trna)
head(df[,1:20])
table(df$cluster)

#install.packages("glmnet")
library(glmnet)
fit = glmnet(x, y)
x=trna

coefMat = matrix(NA, nrow=dim(trna)[2]+1, ncol=10)
#predict cluster 1
for ( i in 1:10) {
  y=cluster==i
  #cvfit.lasso = cv.glmnet(x[1:1000,], y[1:1000], family="binomial", alpha=1)
  cvfit.alpha5 = cv.glmnet(x, y, family="binomial", alpha=0.5)
  plot(cvfit.alpha5)
  coef(cvfit.alpha5, s = "lambda.min")
  newy=predict(cvfit.alpha5, newx = x[1000:2000,], s = "lambda.min")
  
  library(pROC) 
  #install.packages("pROC")
  obs = as.numeric(y[1000:2000])-1
  pred = as.numeric(newy)-1
  roccurve = roc(obs~pred)
  plot(roccurve, main=roccurve$auc[1])
}
#