#Intro----------------------------------------
# The purpose of this script is to perform the analysis.
# It is divided based on the domains of deviations + defining functions:
#   -functions
#   -baseline condition with no deviations
#   -sample size conditions
#   -outlier conditions
#   -model conditions
#
# All scenarios will be framed as a function where the input is y, to make
# inputting the scenario easier.

#Functions-------------------------------------------

##Extract function-----

#create the extract function with model as input
extr <- function(model){
  
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
extr(model = reg.no)

#checking if same as in model summary
summary(reg.no)
confint(reg.no)

#yes it works


##Other function-----



#Baseline scenario---------------------------------------------------

#having the baseline scenario be a function where you can fill in which
#dependent variable (scenario) you want to examine
baseline <- function(dep){
  
  #for the baseline scenario we only take the first 200 participants
  df.baseline <- df %>% slice(1:200)
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

#values should match: 
df.baseline <- df %>% slice(1:200)
y <- df.baseline$y_no
#perform a regression analysis and extract the statistics
reg <- lm(y ~ x, data = df.baseline)
test <- extr(model = reg)

#evaluate if the same:
identical(fun, test) 



#Sample size conditions----------------

samplesize <- function(dep){
  
  size <- c(170, 195, 200, 205, 230)
  ss <- length(size)
  size.stat <- data.frame(matrix(ncol = 4, nrow = ss)) #4 because four values get saved in the extract function
    colnames(size.stat) <- cn
    
      
  for (i in 1:ss) {
    df.samplesize <- df %>% slice(1:size[i])
    y <- df.samplesize[[dep]]
    
    #perform a regression analysis and extract the statistics
    reg <- lm(y ~ x, data = df.samplesize)
    size.stat[i,] <- extr(model = reg)
    rownames(size.stat)[i] <- paste0("Sample size (", size[i], ")")
  }
    
    return(size.stat)
}

samplesize("y_no")







#Analysis function-------

analysis <- function(dep){
  base.stat <- baseline(dep)
  size.stat <- samplesize(dep)
  
  rbind(base.stat, size.stat)
}

analysis("y_no")
