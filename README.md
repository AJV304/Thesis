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
│   ├── 00_setup
│   ├── 01_datageneration
│   ├── 02_results
│   ├── 03_visuals
├── Files
├── Visuals
├── .Rprofile
├── README.md
├── .gitignore
└── renv.lock
```

### `Thesis.Rproj` 
This is the R project directory in which all scripts and files were generated.

### `Data` 
Two datasets were generated for this project. `results.rds` includes the data with 1,600 repetitions, this is the original number of repetitions. For the robustness check a dataset with 10,000 repetitions was simulated, this can be found under `bigresults.rds`.

### `Scripts`
In this directory, all scripts necessary to analyze the data into results can be found.

#### `01_datageneration`
Although the data sets are also available on this repository, code to generate the data was also included.

#### `02_results`
The scripts in this repository can be used to analyze the datasets. The scripts are organized per research question, per scenario. Data was generated under two scenarios, an effect scenario and no-effect scenario. 

#### `03_visuals`
This directory includes the scripts necessary to create the sankey graph visuals for the results of Research Question 2.





