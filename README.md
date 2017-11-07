# BDS Hackathon

## Schedule

Date/Time: Nov 7th 9am - Nov 8th (midnight)

Room: MR5 3005

Datapalooza: Nov 9th-10th (Th-Fr)

## Overview

Single-cell RNA-seq (scRNA-seq) has now become routine, and there are hundreds of published datasets of single-cell RNA-seq data in various biological systems. One of the key applications of scRNA-seq is to separate cell types. For example, studies may identify novel cell types that previously have been hidden due to population averaging; or, some studies use data to classify individual cells as cancer cells or normal cells, leading to cleaner expression profiles.

A typical analysis uses an unsupervised clustering (like t-SNE, PCA, or MDS) to visualize the high-dimensional expression data and identify clusters of individual cells. These clusters are then annotated *post-hoc* based on their gene expression patterns. Most effort has been in unsupervised analysis of scRNA-seq data, and the features that define the differences in classification are then derived from the factors used in the cluster, but a supervised approach could provide a better way to identify salient features.

Therefore, we are now interested in applying supervised machine learning methods to build models that can classify individual cells into cell types. These models will be useful for (at least) two potential downstream applications:

1. They could span multiple data sets and thereby build a pan-cell-type predictor that could be fed new scRNA-seq data from a new experiment and be used to classify known cell types.

2. They will provide a novel look at the feature set that defines a cell type, which is not revealed by the unsupervised methods.

We should seek to build a reproducible piece of software that will enable others with scRNA-seq data to either re-run our analysis to build a predictor for the new dataset, or to use the predictor we have built to classify newly sequenced single cells.

## Compute organization

Each of you should be a member of the `bds_tg` group on Rivanna. We have an allocation of disk space on Rivanna at `/sfs/lustre/allocations/bds_tg`. I suggest everyone set an environment variable to point to this for easy communication:
```
export BDSDATA="/sfs/lustre/allocations/bds_tg"
```

You should also have access to a compute credit allocation, also called `bds_tg` (use `allocations` to see yours).

Please commit any code into this repository.

## Data
* [GEO Data from Stoeckius 2017](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE100866)
* [Stoeckius et al. 2017 Manuscript](https://www.nature.com/nmeth/journal/v14/n9/full/nmeth.4380.html) - CITE-seq


## Resources
Some planning ideas (from aakrosh):

* https://github.com/hackseq
* https://github.com/NCBI-Hackathons/Run_an_NCBI-style_hackathon
* https://github.com/NCBI-Hackathons/Refactoring_Bioinformatics_Pipelines

Maching learning links:
* http://h2o.ai - machine learning library (with R and python bindings)
* [Caret R package](http://topepo.github.io/caret/visualizations.html) - Universal R interface to various tools.
* [mlr R package](https://cran.r-project.org/web/packages/mlr/index.html) - Universal R interface to various tools.
* [R tensorflow](https://github.com/rstudio/tensorflow)
* [TensorFlow](https://www.tensorflow.org/) - Google's deep learning library
* [Hu et al. 2016](https://www.ncbi.nlm.nih.gov/pubmed/28155657) - BMC Genomics paper on supervised classification of single-cell RNA. *A machine learning approach for the identification of key markers involved in brain development from single-cell transcriptomic data.*

scRNA  analysis:
* [Seurat](http://satijalab.org/seurat/) - R package for unsupervised analysis and visualization
* [Brief Review of scRNA-Seq Tools](https://www.nature.com/news/single-cell-sequencing-made-simple-1.22233)
* [CIDR](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-017-1188-0) Unsupervised clustering method
* [scTDA](https://github.com/pcamara/scTDA) - topological data analysis of high-throughput single-cell RNA-seq data. From [Rizvi et al. 2017](https://www.nature.com/articles/nbt.3854).

scRNA data:
* https://www.encodeproject.org/search/?searchTerm=GM12878&type=Experiment&assay_title=single+cell+RNA-seq 
* https://www.encodeproject.org/experiments/ENCSR000AJE/
* [single cell ATAC-seq data](https://www.nature.com/nature/journal/v523/n7561/pdf/nature14590.pdf)
* [scRNASeqDB](https://bioinfo.uth.edu/scrnaseqdb/) - Human scRNA-seq Database
* [Villani & Satija et al. 2017](http://doi.org/10.1126/science.aah4573) - *Single-cell RNA-seq reveals new types of human blood dendritic cells, monocytes, and progenitors*. both processed and raw data available
* [DeLaughter et al. 2017 ](https://www.ncbi.nlm.nih.gov/pubmed/27840107) - *Single-Cell Resolution of Temporal Gene Expression during Heart Development*. Single-cell RNA sequencing of >1,200 murine cells isolated at seven time points spanning embryonic day 9.5 (primordial heart tube) to postnatal day 21 (mature heart). Using unbiased transcriptional data, we classified cardiomyocytes, endothelial cells, and fibroblast-enriched cells, thus identifying markers for temporal and chamber-specific developmental programs
* [Lake et al.](https://www.ncbi.nlm.nih.gov/pubmed/27339989) - *Neuronal subtypes and diversity revealed by single-nucleus RNA sequencing of the human brain.* Raw data is already available on Rivanna.
* [Patel et al. 2014](https://www.ncbi.nlm.nih.gov/pubmed/24925914) *Single-cell RNA-seq highlights intratumoral heterogeneity in primary glioblastoma.*
* [Saliba et al. 2016](https://www.nature.com/articles/nmicrobiol2016206) *Single-cell RNA-seq ties macrophage polarization to growth rate of intracellular Salmonella*
* [Avraham et al. 2015](https://www.ncbi.nlm.nih.gov/pubmed/26343579) *Pathogen Cell-to-Cell Variability Drives Heterogeneity in Host Immune Responses*
* [Habib et al. 2017](https://www.nature.com/nmeth/journal/v14/n10/full/nmeth.4407.html) - Dronc-seq

Notes on approaches taken:
* In two scRNA-seq cancer studies, groups identified tumor malignancy/state using CNV analysis of scRNA-seq data (average of normalized expression levels over relatively large stretches of the genome).  This tended to be followed by unsupervised clustering and expression of key marker genes to identify cell types.  One group identified critical/disease distinguishing genes by their principal component loadings/correlation to PC1, PC2 or PC3.  This last step is where supervised machine learning approaches could do a better job.   
