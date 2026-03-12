#create overarching function

analysis <- function(iter, n, b0, b1_yes, b_z, b_d, dep) {
  
  #create empty dataframe for the statistics 
  stats <- data.frame(matrix(ncol = 5, nrow = (9*iter)))
  colnames(stats) <- c("b1","p.value","lower.ci","upper.ci", "condition")
  
  for (i in 1:iter) {
    
    #set.seed(i)
    
    #simulate a dataset
    df <- dgm(n, b0, b1_yes, b_z, b_d)
    
    #run all scenarios on the dataset
    result <- conditions(df, dep)
    
    #add scenarios to the stats dataset and add iteration number
    stats[(((i-1)*9+1)):(i*9),] <- result
    stats$iteration[(((i-1)*9+1)):(i*9)] <- i 
    
  }
  
  return(stats)
  }


