# BDS Hackathon

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

scRNA data and analysis:
* [Seurat](http://satijalab.org/seurat/) - R package for unsupervised analysis and visualization
* https://www.encodeproject.org/search/?searchTerm=GM12878&type=Experiment&assay_title=single+cell+RNA-seq 
* https://www.encodeproject.org/experiments/ENCSR000AJE/
* [single cell ATAC-seq data](https://www.nature.com/nature/journal/v523/n7561/pdf/nature14590.pdf)
* [scRNASeqDB](https://bioinfo.uth.edu/scrnaseqdb/) - Human scRNA-seq Database
* [Brief Review of scRNA-Seq Tools](https://www.nature.com/news/single-cell-sequencing-made-simple-1.22233)

Here are some other papers with single-cell RNA data, these from brain. I've already downloaded all this data:

Lake, B. B.; Ai, R.; Kaeser, G. E.; Salathia, N. S.; Yung, Y. C.; Liu, R.; Wildberg, A.; Gao, D.; Fung, H.-L.; Chen, S.; Vijayaraghavan, R.; Wong, J.; Chen, A.; Sheng, X.; Kaper, F.; Shen, R.; Ronaghi, M.; Fan, J.-B.; Wang, W.; Chun, J. & Zhang, K. Neuronal subtypes and diversity revealed by single-nucleus RNA sequencing of the human brain. Science (New York, N.Y.), 2016, 352, 1586-1590

Patel, A. P.; Tirosh, I.; Trombetta, J. J.; Shalek, A. K.; Gillespie, S. M.; Wakimoto, H.; Cahill, D. P.; Nahed, B. V.; Curry, W. T.; Martuza, R. L.; Louis, D. N.; Rozenblatt-Rosen, O.; Suvà, M. L.; Regev, A. & Bernstein, B. E. Single-cell RNA-seq highlights intratumoral heterogeneity in primary glioblastoma. Science (New York, N.Y.), 2014, 344, 1396-1401


Pipeline development links:
* [Looper](http://looper.readthedocs.io/) - my python package that submits pipelines to clusters
* [Pypiper](http://pypiper.readthedocs.io/) - my python package for building pipelines

Notes on approaches taken:
* In two scRNA-seq cancer studies, groups identified tumor malignancy/state using CNV analysis of scRNA-seq data (average of normalized expression levels over relatively large streches of the genome).  This tended to be followed by unsupervised clustering and expression of key marker genes to identify cell types.  One group identified critical/disease distinguishing genes by their principal component loadings/correlation to PC1, PC2 or PC3.  This last step is where supverised machine learning approaches could do a better job.   
