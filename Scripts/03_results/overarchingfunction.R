#create overarching function

thesis <- function(iter, n, b0, b1_no, b1_yes, b_z, b_d, dep) {
  
  stats <- data.frame(matrix(ncol = 5, nrow = (9*iter)))
  colnames(stats) <- c(cn, "condition")
  
  for (i in 1:iter) {
    
    #set.seed(i)
    df <- dgm(n, b0, b1_no, b1_yes, b_z, b_d)
    result <- analysis(df, dep)
    stats[(((i-1)*9+1)):(i*9),] <- result
    stats$iteration[(((i-1)*9+1)):(i*9)] <- paste("iteration", i, sep = " ")
    #rownames(stats)[(((i-1)*9+1)):(i*9)] <- paste0(rownames(result), " iteration ", i)
    
  }
  
  return(stats)
  }


