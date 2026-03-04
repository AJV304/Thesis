#create overarching function

thesis <- function(iter, n, b0, b1_no, b1_yes, b_z, b_d, dep) {
  
  #create empty dataframe for the statistics 
  stats <- data.frame(matrix(ncol = 5, nrow = (9*iter)))
  colnames(stats) <- c(cn, "condition")
  
  for (i in 1:iter) {
    
    #set.seed(i)
    
    #simulate a dataset
    df <- dgm(n, b0, b1_no, b1_yes, b_z, b_d)
    
    #run all scenarios on the dataset
    result <- analysis(df, dep)
    
    #add scenarios to the stats dataset and add iteration number
    stats[(((i-1)*9+1)):(i*9),] <- result
    stats$iteration[(((i-1)*9+1)):(i*9)] <- i #paste("iteration", i, sep = " ")
    
  }
  
  return(stats)
  }


