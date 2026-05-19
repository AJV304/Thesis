Hello everyone,

This repository includes all files and information regarding my master thesis project: "Busy Making Other Plans: A Simulation Study on the Effects of Deviations from Preregistrations"
With this simulation study, I investigated the effects of forced and opportunistic deviations on type I and type II error rates.

The goal of preregistration is to limit researcher degrees of freedom and improve the reliability of research.
Whilst preregistrations are becoming more common, so are deviations from preregistration. 
When people no longer adhere to their preregistered plan, they might be inflating their risk of false negative or false positive outcomes. 
To investigate this phenomenon, nine deviations were identified, which were either 1) common, 2) risky, or 3) deemed unjustifiable. 
The error rates for these deviation conditions were simulated and compared to the nominal type I and type II error rates. 
Both forced deviations, over which the researcher had no control, and opportunistic deviations, in which the researcher chose to deviate, were simulated.

The results show that being forced to deviate can inflate the type I and type II error rates but does so only marginally. 
The only forced deviation that is cause for concern is switching outcome variables, this greatly increases the type II error rate. 
Deviating opportunistically is a lot more problematic, as it greatly inflates the type I error rate.

## Repository Structure
This repository is structured as follows:

```bash
├── Thesis.Rproj
├── Data
│   ├── bigresults.rds
│   ├── results.rds
├── Scripts
│   ├── 01_datageneration
│   ├── 02_results
│   ├── 03_visuals
├── Manuscript
├── .Rprofile
├── README.md
├── .gitignore
└── renv.lock
```

### `Thesis.Rproj` 
This is the R project directory in which all scripts and files were generated.

### `Data` 
Two datasets were generated for this project. `results.rds` includes the data with 1,600 repetitions, this is the original number of repetitions. For the robustness check a dataset with 10,000 repetitions was simulated, this can be found under `bigresults.rds`. A separate `R` package was created for data generation and can be found at <https://doi.org/10.5281/zenodo.20099859>. The GitHub repository is not necessary to reproduce the findings of the current projects, as all functions are loaded into this project separately.

### `Scripts`
In this directory, all scripts necessary to analyze the data into results can be found.

#### `01_datageneration`
Although the data sets are also available in this repository, scripts to generate the data were also included. There are two scripts, one for the original analysis of repetition size 1,600 and one for the robustness check with repetition size 10,000.

#### `02_results`
The scripts in this repository can be used to analyze the datasets. The scripts are organized per research question, per scenario. Data was generated under two scenarios, an effect scenario and no-effect scenario. 

#### `03_visuals`
This directory includes the scripts necessary to create the sankey graph visuals for the results of Research Question 2.

### Manuscript
This directory is where the main project files are saved. This project was set up so no scripts needed to be run individually. Instead only one `qmd` need to be rendered to create a reproducible version of the results. The `Thesis.qmd` file can be found in this folder. 


## Reproducing the Results
In order to reproduce my findings, please take the following steps.

1. Reproduce the environment
To make sure you are working with the same version of R and packages you can reproduce my environment using the `renv` package. For this you need: the `renv` package version 1.1.5 and Rstudio 4.4.2 or newer.

- Open the `Thesis.Rproj` file in Rstudio.
- Install the required packages by running the following command in the R console:
`renv::restore()`

Following those steps should ensure that analysis are replicated using the same software as in the original analysis.

2. Run the Script
Only one script needs to be rendered in order to reproduce the results. The `Thesis.qmd` file can be found under the `Manuscript` folder. Open this file in RStudio and render it. This should run all scripts found in the `Scripts` folder and print the output in one pdf file. Running the script might take a bit longer the first time due to packages needing to be installed or updated. 

## Ethics and Privacy
Ethics approval for this study was obtained from the Faculty of Social Sciences at Utrecht University under number #25-1980. Since the data for this study was simulated, there are no privacy concerns. 





