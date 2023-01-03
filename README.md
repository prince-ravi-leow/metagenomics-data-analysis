# Introduction
This repository contains a curated data analysis, conducted as part of the bioinformatics-focused master’s course, [*Applied Methods in Metagenomics*](https://kurser.dtu.dk/course/2021-2022/23260?menulanguage=en), taken in the fall of 2022, at the Technical University of Denmark (DTU). 

This data analysis will primarily focus on the composition of AMR gene classes in 3 genetic samples, as well as classifying bacteria that are likely present. For more details on the metagenomic pipeline, please refer to the `poster.pdf`, that was submitted as part of the course.

![Full metagenomic workflow (Image credit: Adikrishna Murali Mohan)](https://github.com/prince-ravi-leow/metagenomics-data-analysis/blob/master/meta_flowchart.jpg?raw=true)

# Contents
## Code
The Jupyter Notebook (`metagenomics_data_analysis.ipynb`) contains a systematic documentation of our data analysis process, along with our findings, insights, and visualisations. 

An export of this notebook containing only the results and no code, has also been included in HTML format.

The data analysis was conducted primarily using `python`, although select sections were conducted using the `tidyverse` package suite in `R`. Such sections will be clearly marked, and corresponding `R` code is provided in `meta.R`.

## Data
The outputs from the pipeline used in this study:
* **`kma`** (k-mer alignment) for studying the sample AMR gene composition. `kma` was aligned against two databases:
    * ResFinder: The `*.mapstat` files, contain the identified and quantified AMR gene fragments. These have been pre-treated, and merged into `resfinder_abundance_table_24_25_38.csv`. 3 additional partial ResFinder database files, containing AMR gene names, corresponding AMR class and length are included.
    * SILVA: The `*.mapstat` classifies gene fragments taxonomically, and are used to determine the bacterial content of our samples. 
* **`CheckM2`** to assess the metagenomic bin quality. These have have been pre-treated, and merged into: `edited_quality_report_ALL_SAMPLES.csv`.
* **`GTDB-tk`**: for studying the microbial diversity. The taxonomical annotations for all 3 samples have been pre-treated, and split into their respective `summary.tsv` files.   

# Acknowledgements
While the bulk of the data analysis was worked on by this repo's two authors André and Prince, we would like to acknowledge our third group member Adikrishna Murali Mohan, for her effort throughout the coursework, the final poster report, and the wonderful flowchart of our full metagenomic workflow.

The data analysed in this study, was obtained courtesy of DTU as part of the [Danish VETII project](https://www.ebi.ac.uk/ena/browser/view/PRJEB26961?show=reads), and was passed through a specialised metagenomic pipeline, for studying anti-microbial resistance (AMR) in bacteria. The entire metagenomic pipeline, was run on DTU's HPC cluster [Computerome 2.0 (CR2)](https://www.computerome.dk/).