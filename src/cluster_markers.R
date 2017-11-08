options(stringsAsFactors=FALSE)
setwd("/Users/Cassie/Box Sync/hackathon/data/")

#d = read.csv("GSE100866_CBMC_8K_13AB_10X-ADT_clr-transformed.csv.gz", header=TRUE, row.names=1)
#saveRDS(d, file="CBMC_8K_13AB_10X-ADT_clr-transformed.rds")
d = readRDS(file="CBMC_8K_13AB_10X-ADT_clr-transformed.rds")
dt.df = as.data.frame(t(d))
#dt.mat = t(d)
dt.mat = dt.mat[1:100,]

#Look at univariate distributions
hist(dt.df$CD3)
hist(dt.df$CD56)


#tSNE dimension reduction
install.packages("tsne")
library(tsne)
s = tsne(dt.mat)
plot(s[,1],s[,2])


#clustering
#install.packages("cluster")
#install.packages("magrittr")
#install.packages("factoextra")
library("cluster")
library("factoextra")
library("magrittr")
library("ggplot2")

#visualize cell clusters
res.dist <- get_dist(dt.mat, stand = TRUE, method = "pearson")
pdf("cluster_heatmap_adt.pdf")
fviz_dist(res.dist, 
          gradient = list(low = "#00AFBB", mid = "white", high = "#FC4E07"))
dev.off()

#hierarchical clustering
res.hc <- test %>%
  scale() %>%                    # Scale the data
  dist(method = "euclidean") %>% # Compute dissimilarity matrix
  hclust(method = "ward.D2")     # Compute hierachical clustering
# Visualize using factoextra
# Cut in 4 groups and color by groups
fviz_dend(res.hc, k = 4, # Cut in four groups
          cex = 0.5, # label size
          k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE, # color labels by groups
          rect = TRUE # Add rectangle around groups
)

