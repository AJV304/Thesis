#This function deviates from your baseline scenario by adding a continuous or
#dichotomous covariate to the linear regression.

models <- function(df, dep) {
  
  #create dataframe to save statistics
  models.stat <- data.frame(matrix(ncol = 4, nrow = 2)) #4 because four values get saved in the extract function, 2 columns for methods
  colnames(models.stat) <- c("b1","p.value","lower.ci","upper.ci")
  
  #we take the first 200 participants, then
  #remove outliers >3sd
  df.models <- df %>% slice(1:200) 
  
  df.models <- df.models %>% filter(
    .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
    .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
  )
  
  #save dependent variable as y
  y <- df.models[[dep]]
  
  #then we run the different possible models
  ##continuous covariate
  reg <- lm(y ~ x + z, data = df.models)
  models.stat[1,] <- extr(model = reg)
  models.stat$condition[1] <- "Continuous covariate"
  
  ##dichotomous covariate
  reg <- lm(y ~ x + d, data = df.models)
  models.stat[2,] <- extr(model = reg)
  models.stat$condition[2] <- "Dichotomous covariate"
  
  #return the statistics as output
  return(models.stat)
}
