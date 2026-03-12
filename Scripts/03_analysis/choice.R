#choice function (run on output of thesis function)

choice <- function(scenarios){
  #save the number of iterations as x
  x <- length(unique(scenarios[,6]))
  
  #create empty data frame with 1 row per iteration
  final <- data.frame(matrix(ncol = sum(ncol(scenarios), 1), nrow = x)) 
  colnames(final) <- c(colnames(scenarios), "deviations")

  #for each iteration follow the rank order to check which result to select
  for (i in 1:x){
    #select the current iteration
    it <- scenarios %>% filter(iteration == i)
    
    #check if the baseline scenario is significant
    if (it[it$condition == "Baseline", "p.value"] < 0.05){
      #if it is, then select the baseline scenario
      final[i,] <- it[it$condition == "Baseline",]
      final[i, "deviations"] <- "NA"
    } else {
      if (any(it[,"p.value"] < 0.05)){
        sig <- it %>% filter(p.value < 0.05)
        final[i,] <- sig %>% slice_sample(n = 1)
        final[i, "deviations"] <- nrow(sig)
        } else { 
          final[i,] <- it[it$condition == "Baseline",]
          final[i,"deviations"] <- 0
          }
    }
  }
  
  return(final)
  }
     
              


