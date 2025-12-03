#----------------------------------------
# The purpose of this script is to perform the analysis.
# It is divided based on the domains of deviations:
#   -baseline condition with no deviations
#   -outlier deviations
#   -sample size deviations
#   -model deviations

#-------------------------------------------
#Baseline Scenario


#Extract function


statistics <- data.frame(matrix(ncol = 4, nrow = 1)) #4 columns, one for each saved statistic


#linear model
reg.no <- lm(y_no ~ x, data = df)
summary(reg.no)

#calculate confidence intervals
ci <- predict(
  reg.no, 
  interval = "confidence", 
  level = 0.95
)

extract <- function(){
statistics[i,1] <- reg.no$coefficients[2,1] #save regression coefficient b1
statistics[i,2] <- reg.no$coefficients[2,4] #save p-value
statistics[i,3] <- ci[,2] #save confidence interval lower
statistics[i,4] <- ci[,3] #save confidence interval upper
}