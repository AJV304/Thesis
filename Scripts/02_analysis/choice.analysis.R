choice.analysis <- function(df, dep){
  
  #run baseline model
  base.stat <- baseline(df, dep)
  
  #is the baseline value below 0.05?
  repl <- ifelse(base.stat[2] < 0.05, "yes", "no")
  
  #
  base <- base.stat[2]
  
  if (base < 0.05) {
    final <- base
  } else {
    size.stat <- samplesize(df, dep)
    samp5 <- size.stat[3,2]
    
    if (samp5 < 0.05) {
      final <- samp5
    } else {
      samp15 <- size.stat[4,2]
      
      if (samp15 < 0.05) {
        final <- samp15
      } else {
        
      }
    }
  }
  
  final
   
  #run deviation conditions
  size.stat <- samplesize(df, dep)
  outlier.stat <- outlier(df, dep)
  model.stat <- models(df, dep)

  frames <- list(base.stat, size.stat, outlier.stat, model.stat)
  out <- do.call(rbind, frames)
  out$replaced <- 0
  
  if (repl == "yes") {
    
    replacethese <- out[[2]] > 0.05
    out[replacethese, 1:3] <- base.stat[, 1:3]
    out$replaced[replacethese] <- 1 
  }
  
  return(out)
}


  

