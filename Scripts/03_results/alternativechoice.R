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
    if (it[1,2] < 0.05){
      #if it is, then select the baseline scenario
      final[i,] <- it[1,]
    } else {
      #otherwise, check if the sample size 85% is significant
      if (it[2,2] < 0.05){
        #if it is, then select the ss85%
        final[i,] <- it[2,]
      } else {
        #otherwise, check ss 97.5%
        if (it[3,2] < 0.05){
          final[i,] <- it[3,]
        } else {
          if (it[4,2] < 0.05){
            final[i,] <- it[4,]
          } else {
            if (it[5,2] < 0.05){
              final[i,] <- it[5,]
            } else {
              if (it[6,2] < 0.05){
                final[i,] <- it[6,]
              } else {
                if (it[7,2] < 0.05){
                  final[i,] <- it[7,]
                } else {
                  if (it[8,2] < 0.05){
                    final[i,] <- it[8,]
                  } else {
                    if (it[9,2] < 0.05){
                      final[i,] <- it[9,]
                    } else {
                      final[i,] <- it[1,]
                    }}}}}}}}}
  }
  
  return(final)
  }
     
              


