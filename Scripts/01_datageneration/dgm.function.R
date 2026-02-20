#------------------------------------
# The purpose of this script is to simulate data according to the data
# generating mechanism.

#---------------------------------------------

#make a function to generate data with the effect size as a settable argument
dgm <- function(effectsize){
  
  #setting set values
  n <- 230      #200 for the baseline condition + 15% for the max sample size increase condition
  b0 <- 0       #intercept
  b1 <- effectsize    #main effect
  b_z <- 0.12   #effect of continuous covariate
  b_d <- 0.12   #effect of dichotomous covariate
  
  #setting a seed
  set.seed(1979094)
  
  
  #sampling from distributions
  ##simulating the independent variable x
  x <- rnorm(n = n,
             mean = 0,
             sd = 1)
  
  ##simulating the continuous covariate z
  z <- rnorm(n = n,
             mean = 0,
             sd = 1)
  
  ##simulating the dichotomous covariate d
  d <- rbinom(n = n,
              size = 1,
              prob = 0.5)
  
  ##simulating random error epsilon
  re <- rnorm(n = n, mean = 0, sd = 1)
  
  
  #formulating the regression formula
  ##simulating the dependent variable y
  y <-  b0 + b1*x + b_z*z + b_d*d + re

  
  #create data frame
  df <- data.frame(x,y, z, d)
  
  #replacing 5% of values with potentially random outliers
  ##creating an increased random error
  re_outlier_high <- rnorm(n = n, mean = 4, sd = 4)
  re_outlier_low <- rnorm(n = n, mean = -4, sd = 4)
  
  ##creating new dependent variable with increased outlier probability
  y_outlier_high <- b0 + b1*x + b_z*z + b_d*d + re_outlier_high
  y_outlier_low <- b0 + b1*x + b_z*z + b_d*d + re_outlier_low
  
  #replace 5% (list) of all y values (x) with a value from the new dependent variable (values)
  repla <- sample(1:n, 0.05*n)
  
  df_outlier <- df %>% mutate(y = 
                                replace(x      = y, 
                                        list   = repla, 
                                        values = ifelse(runif(length(repla)) < 0.5, sample(y_outlier_high, 0.05*n), sample(y_outlier_low, 0.05*n))))
  
  
  #request the two data sets as output of the function
  return(list(df, df_outlier))
}

#extract the dataframes from the list
df <- dgm(0)[[1]]
df_outlier <- dgm(0)[[2]]

#graphical view
summary(df)
summary(df_outlier)

hist(df$y, ylim = c(0,80), xlim = c(-10, 10), breaks = 8)
hist(df_outlier$y, ylim = c(0,80), xlim = c(-10, 10), breaks = 14)


hist(df$y, breaks = 14)
hist(df_outlier$y, breaks = 14)
