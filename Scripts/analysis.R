#Intro----------------------------------------
# The purpose of this script is to perform the analysis.
# It is divided based on the domains of deviations + defining functions:
#   -functions
#   -baseline condition with no deviations
#   -outlier deviations
#   -sample size deviations
#   -model deviations

#Functions-------------------------------------------

##Extract function-----

#create the extract function with model as input
extract <- function(model){
  
  #create temporary data frame
  statistics <- data.frame(matrix(ncol = 4, nrow = 1))
  colnames(statistics) <- c("b1","p-value","lower ci","upper ci")
  
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

###test-----
#create data set
df <- dgm()

#creating a linear model to extract from linear model
reg.no <- lm(y_no ~ x, data = df)

#extraction
extract(model = reg.no)

#checking if same as in model summary
summary(reg.no)
confint(reg.no)

#yes it works

##Other function-----

#Baseline scenario---------------------------------------------------