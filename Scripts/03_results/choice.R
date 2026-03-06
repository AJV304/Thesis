#choice function (run on output of thesis function)

choice <- function(scenarios){
  #save the number of iterations as x
  x <- length(unique(scenarios[,6]))
  
  #create empty data frame with 1 row per iteration
  final <- data.frame(matrix(ncol = ncol(scenarios), nrow = x)) 

  #for each iteration follow the rank order to check which result to select
  for (i in 1:x){
    #select the current iteration
    it <- scenarios %>% filter(iteration == i)
    
    #check if the baseline scenario is significant
    if (it[it$condition == "Baseline", "p.value"] < 0.05){
      #if it is, then select the baseline scenario
      final[i,] <-it[it$condition == "Baseline",]
    } else {
      if (any(it[,"p.value"] < 0.05)){
        sig <- it %>% filter(p.value < 0.05)
        final[i,] <- sig %>% slice_sample(n = 1)
        } else { 
          final[i,] <- it[it$condition == "Baseline",]
          }
    }
  }

  
  colnames(final) <- colnames(scenarios)
  return(final)
  }
     
              


