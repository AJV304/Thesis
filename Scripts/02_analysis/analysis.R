#Intro----------------------------------------
# The purpose of this script is to perform the analysis.
# It is divided based on the domains of deviations + defining functions:
#   -functions
#   -baseline condition with no deviations
#   -sample size conditions
#   -outlier conditions
#   -model conditions
#   -overarching analysis function
#
# All scenarios will be framed as a function where the input is y, to make
# inputting the scenario easier.

#Functions and objects----------------------------------------------------------

##Objects
cn <- c("b1","p-value","lower-ci","upper-ci")

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

###test-----
#create data set

set.seed(1979094)
df <- dgm(n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06)

#creating a linear model to extract from linear model
reg.no <- lm(y_no ~ x, data = df)

#extraction
extr(model = reg.no)

#checking if same as in model summary
summary(reg.no)
confint(reg.no)

#yes it works


##Other function-----



#Baseline scenario--------------------------------------------------------------

#having the baseline scenario be a function where you can fill in which
#dependent variable (scenario) you want to examine
baseline <- function(dep){
  
  #for the baseline scenario we only take the first 200 participants, then
  #remove outliers >3sd
  df.baseline <- df %>% slice(1:200) 
  
  df.baseline <- df.baseline %>% filter(
    .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
    .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
  )
  
  #save dependent variable as y
  y <- df.baseline[[dep]]
  
  #perform a regression analysis and extract the statistics
  reg <- lm(y ~ x, data = df.baseline)
  base.stat <- extr(model = reg)
  row.names(base.stat) <- c("Baseline")
  
  return(base.stat)
}

#run the function
fun <- baseline("y_no")
baseline("y_no")

##test----

#testing to see if outlier exclusion works 
dep <- "y_no"
df.baseline <- df %>% slice(1:200)

#defining boundary values to check whether data falls within boundary after removal
u.lim <- mean(df.baseline$y_no) + 3*sd(df.baseline$y_no)
l.lim <- mean(df.baseline$y_no) - 3*sd(df.baseline$y_no)

#remove outliers based on 3 sd
df.baseline <- df.baseline %>% filter(
  .data[[dep]] >= (mean(.data[[dep]]) - 3*sd(.data[[dep]])),
  .data[[dep]] <= (mean(.data[[dep]]) + 3*sd(.data[[dep]]))
)

#evaluate is 
max(df.baseline$y_no) <= u.lim
min(df.baseline$y_no) >= l.lim
#values should match: 
df.baseline <- df %>% slice(1:200) %>% filter(
  .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
  .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
)
y <- df.baseline$y_no

#perform a regression analysis and extract the statistics
reg <- lm(y ~ x, data = df.baseline)
test <- extr(model = reg)
rownames(test) <- "Baseline"

#evaluate if the same:
identical(fun, test) 



#Sample size conditions---------------------------------------------------------

samplesize <- function(dep){
  
  #specify the alternative sample sizes to test
  size <- c(170, 195, 205, 230)
  ss <- length(size)
  
  #create empty data frame to save the output in 
  size.stat <- data.frame(matrix(ncol = 4, nrow = ss)) #4 because four values get saved in the extract function
    colnames(size.stat) <- cn
    
  #create forloop which tests for each different sample size    
  for (i in 1:ss) {
    #take the specified size from the full data set
    df.samplesize <- df %>% slice(1:size[i])
    #filter the outliers from the data
    df.samplesize <- df.samplesize %>% filter(
      .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
      .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
    )
    
    #use the specified depedent variable as the dependent variable
    y <- df.samplesize[[dep]]
    
    #perform a regression analysis and extract the statistics
    reg <- lm(y ~ x, data = df.samplesize)
    size.stat[i,] <- extr(model = reg)
    rownames(size.stat)[i] <- paste0("Sample size (", size[i], ")")
  }
   
     #return the statistics as output 
    return(size.stat)
}

#call function in no effect scenario 
samplesize("y_no")

##test----

#manual test for ss 170
df.samplesize <- df %>% slice(1:170)
df.samplesize <- df.samplesize %>% filter(
  df.samplesize$y_no >= mean(df.samplesize$y_no) - 3*sd(df.samplesize$y_no),
  df.samplesize$y_no <= mean(df.samplesize$y_no) + 3*sd(df.samplesize$y_no)
)
reg <- lm(y_no ~ x, data = df.samplesize)
test <- extr(model = reg)
rownames(test) <- "Sample size (170)"

#function test
fun <- samplesize("y_no")

#are they the same?
identical(test, fun[1,])

#manual test for ss 195
df.samplesize <- df %>% slice(1:195)
df.samplesize <- df.samplesize %>% filter(
  df.samplesize$y_no >= mean(df.samplesize$y_no) - 3*sd(df.samplesize$y_no),
  df.samplesize$y_no <= mean(df.samplesize$y_no) + 3*sd(df.samplesize$y_no)
)

reg <- lm(y_no ~ x, data = df.samplesize)
test <- extr(model = reg)
rownames(test) <- "Sample size (195)"

#function test
fun <- samplesize("y_no")

#are they the same?
identical(test, fun[2,])



#Outlier conditions-------------------------------------------------------------

outlier <- function(dep){
  
  #create dataframe to save statistics
  outlier.stat <- data.frame(matrix(ncol = 4, nrow = 2)) #4 because four values get saved in the extract function, 2 columns for methods
  colnames(outlier.stat) <- cn
  
  #for the outlier scenario we only take the first 200 participants
  df.outlier <- df %>% slice(1:200)
  
  ##perform baseline regression in order to identify outliers with Cook's
  y <- df.outlier[[dep]]
  reg <- lm(y~x, data = df.outlier)
  
  #Strict Z-scores (2 sd)
  ##exclude outliers based on z-scores
  df.outlier$z <- scale(df.outlier[[dep]])
  df.ex.z <- df.outlier %>% filter(between(z, -2, 2))
  
  ##perform regression for the z-score condtion
  y <- df.ex.z[[dep]]
  reg.ex.z <- lm(y~x, data = df.ex.z)
  outlier.stat[1,] <- extr(model = reg.ex.z)
  rownames(outlier.stat)[1] <- "Strict z-score"
  
  #Cook's
  ##exclude outliers based on Cook's distance
  df.outlier$cook <- cooks.distance(reg)
  df.ex.cook <- df.outlier %>% filter(between(cook, 0, 1))
  
  ##perform regression for the Cook's condition
  y <- df.ex.cook[[dep]]
  reg.ex.cook <- lm(y~x, data = df.ex.cook)
  outlier.stat[2,] <- extr(model = reg.ex.cook)
  rownames(outlier.stat)[2] <- "Cook's"
  
  #return the statistics as output 
  return(outlier.stat)
}

outlier("y_no")

##test----

set.seed(1979094)
df <- dgm()

#calculate z-scores outside of function
#for the outlier scenario we only take the first 200 participants
df.outlier <- df %>% slice(1:200)

##perform baseline regression in order to identify outliers with Cook's
reg <- lm(y_no~x, data = df.outlier)

#Z-scores
##exclude outliers based on z-scores
df.outlier$z <- scale(df.outlier$y_no)
df.ex.z <- df.outlier %>% filter(between(z, -3, 3))

##perform regression for the z-score condtion
reg.ex.z <- lm(y_no~x, data = df.ex.z)
test <- extr(model = reg.ex.z)
rownames(test) <- "Z-score"

#z-scores according to function
fun <- outlier("y_no")

#are they identical?
identical(fun[1,], test)

#Cook's
##exclude outliers based on Cook's distance
df.outlier$cook <- cooks.distance(reg)
df.ex.cook <- df.outlier %>% filter(between(cook, 0, 1))

##perform regression for the Cook'S condition
reg.ex.cook <- lm(y_no~x, data = df.ex.cook)
test <- extr(model = reg.ex.cook)
rownames(test) <- "Cook's"

#are they identical?
identical(fun[2,], test)



#Model conditions---------------------------------------------------------------


##test----


#Analysis function--------------------------------------------------------------

#combining the condition functions to output one dataset
analysis <- function(dep){
  base.stat <- baseline(dep)
  size.stat <- samplesize(dep)
  outlier.stat <- outlier(dep)
  #model.stat <- model(dep)
  
  frames <- list(base.stat, size.stat, outlier.stat) #, model.stat
  do.call(rbind, frames)
}

analysis("y_no")

