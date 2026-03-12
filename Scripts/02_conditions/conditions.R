#combining the condition functions to output one dataset

conditions <- function(df, dep){
  base.stat <- baseline(df, dep)
  size.stat <- samplesize(df, dep)
  outlier.stat <- outlier(df, dep)
  model.stat <- models(df, dep)
  
  frames <- list(base.stat, size.stat, outlier.stat, model.stat)
  do.call(rbind, frames)
}