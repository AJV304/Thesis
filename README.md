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
├── Data
│   ├── css
│   ├── favicon.ico
├── Preregistration
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
├── Thesis.Rproj
└── renv.lock
```

