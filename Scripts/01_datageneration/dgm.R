#Goal-----------------------------------
# The purpose of this script is to simulate data according to the data
# generating mechanism.

#Loose---------------------------------------------

#setting set values
n <- 230      #200 for the baseline condition + 15% for the max sample size increase condition
b0 <- 0       #intercept
b1_no <- 0    #main effect in the no effect scenario
b1_yes <- 0.3 #main effect in the effect scenario
b_z <- 0.12   #effect of continuous covariate
b_d <- 0.12   #effect of dichotomous covariate

#setting a seed
set.seed(1979094)


#sampling from distributions
##simulating the independent variable x
x <- rnorm(n = n, mean = 10, sd = 1)

##simulating the continuous covariate z
z <- rnorm(n = n, mean = 20, sd = 3)

##simulating the dichotomous covariate d
d <- rbinom(n = n, size = 1, prob = 0.5)

##simulating random error epsilon
re <- rnorm(n = n, mean = 0, sd = 1)


#formulating the regression formula
##simulating the dependent variable y
y_no <-  b0 + b1_no * x + b_z * z + b_d * d + re
y_yes <- b0 + b1_yes * x + b_z * z + b_d * d + re

#create data frame
df <- data.frame(x, y_no, y_yes, z, d)

#replacing 5% of values with potentially random outliers
##creating an increased random error
re_outlier_high <- rnorm(n = n, mean = 2, sd = 1)
re_outlier_low <- rnorm(n = n, mean = -2, sd = 1)

##creating new dependent variable with increased outlier probability
y_no_outlier_high <- b0 + b1_no * x + b_z * z + b_d * d + re_outlier_high
y_no_outlier_low <- b0 + b1_no * x + b_z * z + b_d * d + re_outlier_low

y_yes_outlier_high <- b0 + b1_yes * x + b_z * z + b_d * d + re_outlier_high
y_yes_outlier_low <- b0 + b1_yes * x + b_z * z + b_d * d + re_outlier_low

#replace 5% (list) of all y values (x) with a value from the new dependent variable (values)
repla <- sample(1:n, 0.05 * n)

df_outlier <- df %>% mutate(y_no =
                              replace(
                                x      = y_no,
                                list   = repla,
                                values = ifelse(
                                  runif(length(repla)) < 0.5,
                                  sample(y_no_outlier_high, 0.05 * n),
                                  sample(y_no_outlier_low, 0.05 * n)
                                )
                              ))


df_outlier <- df_outlier %>% mutate(y_yes =
                                      replace(
                                        x      = y_yes,
                                        list   = sample(1:n, 0.05 *
                                                          n),
                                        values = ifelse(
                                          runif(length(repla)) < 0.5,
                                          sample(y_yes_outlier_high, 0.05 * n),
                                          sample(y_yes_outlier_low, 0.05 * n)
                                        )
                                      ))

#Alternative y variable
df$y_alt_yes <- rnorm_pre(df$y_yes,
                          mu = 0,
                          sd = 1,
                          r = 0.6)
df$y_alt_no <-  rnorm_pre(df$y_no, mu = 0, sd = 1, r = 0.6)

df_outlier$y_alt_yes <- rnorm_pre(df_outlier$y_yes,
                                  mu = 0,
                                  sd = 1,
                                  r = 0.6)
df_outlier$y_alt_no <-  rnorm_pre(df_outlier$y_no,
                                  mu = 0,
                                  sd = 1,
                                  r = 0.6)

#summary and graphical view
summary(df)
summary(df_outlier)

hist(
  df$y_no,
  ylim = c(0, 80),
  xlim = c(-2, 8),
  breaks = 14
)
hist(
  df_outlier$y_no,
  ylim = c(0, 80),
  xlim = c(-2, 8),
  breaks = 14
)

hist(
  df$y_yes,
  ylim = c(0, 80),
  xlim = c(2, 10),
  breaks = 14
)
hist(
  df_outlier$y_yes,
  ylim = c(0, 80),
  xlim = c(2, 10),
  breaks = 14
)

#As function--------------------
#Turn it into a function with no arguments

#setting set values
n <- 230      #200 for the baseline condition + 15% for the max sample size increase condition
b0 <- 0       #intercept
b1_no <- 0    #main effect in the no effect scenario
b1_yes <- 0.3 #main effect in the effect scenario
b_z <- 0.06   #effect of continuous covariate
b_d <- 0.06   #effect of dichotomous covariate

dgm <- function(n, b0, b1_no, b1_yes, b_z, b_d) {

  
  #DONT SET A SEED BECAUSE THEN EACH DATA SET WILL BE THE SAME HAHA
  #setting a seed
  #set.seed(1979094)
  
  
  #sampling from distributions
  ##simulating the independent variable x
  x <- rnorm(n = n, mean = 0, sd = 1)
  
  ##simulating the continuous covariate z
  z <- rnorm(n = n, mean = 0, sd = 1)
  
  ##simulating the dichotomous covariate d
  d <- rbinom(n = n, size = 1, prob = 0.5)
  
  ##simulating random error epsilon
  re <- rnorm(n = n, mean = 0, sd = 0.05)
  
  
  #formulating the regression formula
  ##simulating the dependent variable y
  y_no <-  b0 + b1_no * x + b_z * z + b_d * d + re
  y_yes <- b0 + b1_yes * x + b_z * z + b_d * d + re
  
  #create data frame
  df <- data.frame(x, y_no, y_yes, z, d)
  
  #replacing 5% of values with potentially random outliers
  ##creating an increased random error
  re_outlier_high <- rnorm(n = n, mean = 3, sd = 1)
  re_outlier_low <- rnorm(n = n, mean = -3, sd = 1)
  
  ##creating new dependent variable with increased outlier probability
  y_no_outlier_high <- b0 + b1_no * x + b_z * z + b_d * d + re_outlier_high
  y_no_outlier_low <- b0 + b1_no * x + b_z * z + b_d * d + re_outlier_low
  
  y_yes_outlier_high <- b0 + b1_yes * x + b_z * z + b_d * d + re_outlier_high
  y_yes_outlier_low <- b0 + b1_yes * x + b_z * z + b_d * d + re_outlier_low
  
  #replace 5% (list) of all y values (x) with a value from the new dependent variable (values)
  repla <- sample(1:n, 0.05 * n)
  
  df <- df %>% mutate(y_no =
                        replace(
                          x      = y_no,
                          list   = repla,
                          values = ifelse(
                            runif(length(repla)) < 0.5,
                            sample(y_no_outlier_high, 0.05 * n),
                            sample(y_no_outlier_low, 0.05 * n)
                          )
                        ))
  
  
  df <- df %>% mutate(y_yes =
                        replace(
                          x      = y_yes,
                          list   = sample(1:n, 0.05 *
                                            n),
                          values = ifelse(
                            runif(length(repla)) < 0.5,
                            sample(y_yes_outlier_high, 0.05 * n),
                            sample(y_yes_outlier_low, 0.05 * n)
                          )
                        ))
  
  #Alternative y variable correlated .6 with y
  df$y_alt_yes <- rnorm_pre(df$y_yes,
                            mu = 0,
                            sd = 1,
                            r = 0.6)
  df$y_alt_no <-  rnorm_pre(df$y_no,
                            mu = 0,
                            sd = 1,
                            r = 0.6)
  
  #request the data set as output of the function
  return(df)
}

#save data from dgm as df data set
set.seed(1979094)
df <- dgm(n, b0, b1_no, b1_yes, b_z, b_d)

#checks
##effect vs no effect
summary(lm(y_yes ~ x, df))
summary(lm(y_no ~ x, df))

##outliers
boxplot(df$y_yes)
boxplot(df$y_no)

#correlation y and y alt
cor(df$y_yes, df$y_alt_yes)
cor(df$y_no, df$y_alt_no)

#
scatter.smooth(df$y_yes, df$x)
points()
