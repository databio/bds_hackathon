folder = "/sfs/lustre/allocations/bds_tg/gtex/GTEx_droncseq_hip_pcf/"
infile = paste0(folder, "GTEx_droncseq_hip_pcf.umi_counts.txt")

d = data.table::fread(infile)

# this is a genes-x-cells matrix with counts
#install.packages("h2o")

library(h2o)
h2o.init(max_mem="16G")

scrna.hex = h2o.uploadFile(infile, destination_frame="scrna")
summary(scrna.hex)