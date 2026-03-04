#supportive
cn <- c("b1","p.value","lower.ci","upper.ci")
rn <- c("Baseline", "Sample size (170)", "Sample size (195)", "Sample size (205)", "Sample size (230)", "Strict z-score", "Cook's", "Continuous covariate", "Dichotomous covariate")

##Extract function-----

#create the extract function with model as input
extr <- function(model){
  
  #create temporary data frame
  statistics <- data.frame(matrix(ncol = 4, nrow = 1))
  colnames(statistics) <- cn
  
  #calculate confidence intervals
  ci <- confint(model, level = 0.95)
  
  #save the summary of the model
  summ <- summary(model)
  
  #save each statistic from the summary of the MODEL in a dataframe
  statistics[1,1] <- summ$coefficients[2,1] #save regression coefficient b1
  statistics[1,2] <- summ$coefficients[2,4] #save p-value
  statistics[1,3] <- ci[2,1] #save confidence interval lower of the b1
  statistics[1,4] <- ci[2,2] #save confidence interval upper of the b1
  
  return(statistics)
}
