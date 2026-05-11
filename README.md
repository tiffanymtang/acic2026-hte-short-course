# Causal Machine Learning for Discovering Heterogeneous Treatment Effects

This repository contains the lecture slides and code tutorial from the ACIC 2026 short course on ``Causal Machine Learning for Discovering Heterogeneous Treatment Effects''.

- `slides/`: contains short course lecture slides
- `R/`: contains R helper functions for coding demonstration
- `notebooks/`: contains quarto/R markdown notebooks for coding demonstration
    - `demo.qmd`: quarto notebook with source code for coding walkthrough
    - `demo.html`: rendered html output from `demo.qmd`
    - `demo.Rmd`: R markdown notebook with source code for coding walkthrough; this is provided for users who prefer R markdown over quarto

## R Packages/Dependencies

To run the `demo.qmd` (or `demo.Rmd`) notebook, you will need to have the following tools installed on your computer:

- [quarto](https://quarto.org/): a scientific and technical publishing system built on Pandoc; you can install quarto [here](https://quarto.org/docs/download/index.html)
- R
    - The code was initially developed using version 4.4.1, but other versions of R will likely work

All R packages can be installed from the `renv.lock` file. To do so,

1. Open the `acic2026-hte-short-course.Rproj` file in RStudio
2. Check that the `renv` R package has been installed on your computer. If not, you can install it via: `install.packages('renv')`
3. After installing the `renv` R package, run the following line of code in your R console:

    ```r
    renv::restore()
    ```

    This will install all R packages specified in the `renv.lock` file, which should be all the R packages needed to run the code in this repository.

Alternatively, you can install the necessary R packages manually. The R packages used in this repository include:

- yaml
- rmarkdown
- here
- dplyr
- ggplot2
- grf
- xnie/rlearner
- tibble
- tidyr
- tidyselect
- GGally
- causalDT
- CRE
- knitr
- lmtest
- sandwich
- glmnet
- xgboost (version 1.7.8.1)
