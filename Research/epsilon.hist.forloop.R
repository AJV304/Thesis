#------------------------------------
# The purpose of this script is to examine the histograms for y and y_outlier
# for using different seeds

#---------------------------------------------
dgm <- function(i){
  
  #setting set values
  n <- 230      #200 for the baseline condition + 15% for the max sample size increase condition
  b0 <- 0       #intercept
  b1 <- 0.3    #main effect
  b_z <- 0.12   #effect of continuous covariate
  b_d <- 0.12   #effect of dichotomous covariate
  
  #setting a seed
  set.seed(i)
  
  
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

#in a forloop, request the histograms of y and outlier y for 5 different seeds
for (i in 1:5) {

  df <- dgm(i)[[1]]
  df_outlier <- dgm(i)[[2]]
  
  hist(df$y, ylim = c(0,120), xlim = c(-10, 10), breaks = 8, main = paste("y, iteration", i))
  hist(df_outlier$y, ylim = c(0,120), xlim = c(-10, 10), breaks = 14, main = paste("y outlier, iteration", i))
  
}
