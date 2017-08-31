# BDS Hackathon

## Schedule

Date/Time: Nov 7th 9am - Nov 8th (midnight)

Room: MR5 3005

Datapalooza: Nov 9th-10th (Th-Fr)



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

Pipeline development links:
* [Looper](http://looper.readthedocs.io/) - my python package that submits pipelines to clusters
* [Pypiper](http://pypiper.readthedocs.io/) - my python package for building pipelines

Notes on approaches taken:
* In two scRNA-seq cancer studies, groups identified tumor malignancy/state using CNV analysis of scRNA-seq data (average of normalized expression levels over relatively large stretches of the genome).  This tended to be followed by unsupervised clustering and expression of key marker genes to identify cell types.  One group identified critical/disease distinguishing genes by their principal component loadings/correlation to PC1, PC2 or PC3.  This last step is where supervised machine learning approaches could do a better job.   
