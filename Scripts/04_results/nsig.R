nsig <- function(df){
  
  #output dataframe, one row per condition, and one column for significance
  #count, one column for condition name to be filled in later
  out <- as.data.frame(matrix(nrow = 10, ncol = 0))
    
  #for each condition, select the number of significant p-values
  conditions <- df[1:10, "condition"]
  
  for (i in 1:10){
    #filter only the results of 1 specific condition
    condition <- df %>% filter(condition == conditions[i])
    
    #count the number of significant p-values
    sig <- condition %>% filter(p.value < 0.5)
    out[i, "n.sig"] <- nrow(sig)
    out[i, "conditions"] <- df[i, "condition"]
  }
  
  
  
  return(out)
}
