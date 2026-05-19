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

To improve transparency, this project was preregistered on March 31st, 2026. The preregistration can be found on [OSF](https://osf.io/y5v8w/overview). 

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
├── Requirements.md
├── .gitignore
└── renv.lock
```

### `Thesis.Rproj` 
This is the R project directory in which all scripts and files were generated.

### `Data` 
Two datasets were generated for this project. `results.rds` includes the data with 1,600 repetitions, this is the original number of repetitions. For the robustness check a dataset with 10,000 repetitions was simulated, this can be found under `bigresults.rds`. A separate `R` package was created for data generation and can be found at <https://doi.org/10.5281/zenodo.20099859>. No information from the `thepack` GitHub repository is necessary to reproduce the findings of the current projects, as all functions are loaded into this project separately. But if you wish to see how the data was generated then please find the scripts in the following repository: [thepack](https://github.com/AJV304/thepack).

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

### Requirements.md
This file contains information about the computational environment that was used to run the analysis. This includes information on which software and packages are required to reproduce the results.

## Reproducing the Results
In order to reproduce my findings, please take the following steps.

1. Reproduce the environment
To make sure you are working with the same version of R and packages, you can reproduce my environment using the `renv` package. For this you need: the `renv` package version 1.1.5 and R 4.4.2 or newer with the matching RStudio and Rtools version. See `Requirements.md` for more information on the computational environment. If those are installed then please:

- Open the `Thesis.Rproj` project in Rstudio.
- Install the required packages by running the following command in the R console:
```
renv::restore()
```

Following those steps should ensure that analysis are replicated using the same software as in the original analysis.

2. Run the `Thesis.qmd`
Only one script needs to be rendered in order to reproduce the results. The `Thesis.qmd` file can be found in the `Manuscript` directory. Open this file in RStudio and click on render. This should run all scripts found in the `Scripts` folder and print the output in one pdf file. Running the script might take a bit longer the first time due to packages needing to be installed or updated.
Dynamic referencing was used in the file wherever possible to ensure reproducible and accurate results. This means inline code was used to report statistics and values instead of hardcoding the numbers. 
This .qmd runs all the scripts available in the `Scripts` folder on this repository. The only exception is that the data is not generated from the data generation scripts but is read from the saved data sets, available in the `Data` folder. If you wish to generate the data yourself, this can be done. In that case:
- Open the `Thesis.qmd` file in RStudio.
- Go to Chunk 5: Generating the data.
- Remove the # before #source("../Scripts/01_datageneration/datageneration.R")
- Remove the rest of the code in the chunk
- Go to Chunk 13: Generating the data with 10,000 repetitions.
- Remove the # before #source("../Scripts/01_datageneration/datageneration_robust.R")
- Remove the rest of the code in the chunk
  
This ensures that the data is generated whilst rendering the script instead of it being read in from the saved data. PLEASE NOTE, that this will greatly increase the rendering time. Generating the data yourself will likely take at least half an hour. 

## Ethics and Privacy
Ethics approval for this study was obtained from the Faculty of Social Sciences at Utrecht University under number #25-1980. Since the data for this study was simulated, there are no privacy concerns. 





