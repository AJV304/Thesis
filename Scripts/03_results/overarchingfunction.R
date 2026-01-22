#create overarching function

thesis <- function(iter, n, b0, b1_no, b1_yes, b_z, b_d, dep) {
  
  stats <- data.frame(matrix(ncol = 4, nrow = (9*iter)))
  colnames(stats) <- cn
  
  for (i in 1:iter) {
    
    set.seed(i)
    df <- dgm(n, b0, b1_no, b1_yes, b_z, b_d)
    result <- analysis(df, dep)
    stats[(((i-1)*9+1)):(i*9),] <- result
    rownames(stats)[(((i-1)*9+1)):(i*9)] <- paste0(rownames(result), " iteration ", i)
    
  }
  
  return(stats)
  }


test <- thesis(iter = 5, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no")
test
      

#benchmark to see how long one iteration takes
microbenchmark(thesis(iter = 1, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no") , times = 100, unit = "s")
