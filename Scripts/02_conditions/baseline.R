#having the baseline scenario be a function where you can fill in which
#dependent variable (scenario) you want to examine

baseline <- function(df, dep){
  
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
  base.stat$condition <- c("Baseline")
  
  return(base.stat)
}