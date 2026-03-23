altfactorial <- function(iter, n, b0, b1, b_z, b_d, dep){
  
  
  #---------------Necessary information ---------------
  #create functions for possible steps 
  
  ###Sample size functions  
  ##do 
  ss1 <- function(df){
    ss <- (nrow(df)/1.15)
    df.samplesize <- df %>% slice(1:ss)
    
    return(df.samplesize)
  }
  
  ## or 
  ss85 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 0.85
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ## or
  ss975 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 0.975
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ## or 
  ss1025 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 1.025
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ## or
  ss115 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 1.15
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ###Outlier functions
  
  ## do
  outz3 <- function(df.samplesize, dep){
    
    df.outlier <- df.samplesize %>% filter(
      .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
      .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
    )
    
    return(df.outlier)
  }
  
  ## or
  outz2 <- function(df.samplesize, dep){
    df.outlier <- df.samplesize
    df.outlier$zscore <- scale(df.samplesize[[dep]])
    df.outlier <- df.outlier %>% filter(between(zscore, -2, 2))
    
    return(df.outlier)
  }
  
  ## or
  outc1 <- function(df.samplesize, dep){
    
    df.outlier <- df.samplesize %>% filter(
      .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
      .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
    )
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x, data = df.outlier)
    
    df.outlier$cook <- cooks.distance(reg)
    df.outlier <- df.outlier %>% filter(between(cook, 0, 1))
    
    return(df.outlier)
  }
  
  ###Model functions
  
  ## do
  modelyx <- function(df.outlier, dep){
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x, data = df.outlier)
    
    return(reg)
  }
  
  ## or
  modelyxz <- function(df.outlier, dep){
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x + z, data = df.outlier)
    
    return(reg)
  }
  
  ## or
  modelyxd <- function(df.outlier, dep){
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x + d, data = df.outlier)
    
    return(reg)
  }
  
  ## or
  modelyax <- function(df.outlier, dep){
    
    ya <- df.outlier[[paste0(dep, "_alt")]]
    reg <- lm(ya ~ x, data = df.outlier)
    
    return(reg)
  }
  
  ###Extraction function
  ext <- function(reg){
    
    result <- extr(reg) 
    
    return(result)
  }
  
  #make a list of steps
  steps <- list(
    selectdata = list(
      ss1 = ss1,
      ss85 = ss85,
      ss975 = ss975,
      ss1025 = ss1025,
      ss115 = ss115
    ),
    excludeoutliers = list(
      outz3 = outz3,
      outz2 = outz2,
      outc1 = outc1
    ),
    runmodel = list(
      modelyx = modelyx,
      modelyxz = modelyxz,
      modelyxd = modelyxd,
      modelyax = modelyax
    ),
    extraction = list(
      ext = ext
    )
  )
  
  #make a grid with all possible step combinations 
  n_opts <- sapply(steps, length)
  combos <- expand.grid(lapply(n_opts, seq_len))
  names(combos) <- names(steps)
  combos$combo_id <- apply(combos, 1, paste0, collapse = "")
  
  #factorial analysis function
  combinations <- function(selectdata, excludeoutliers, runmodel, extraction, data, dependent) {
    
    res <- data
    depen <- dependent
    
    res <- steps$selectdata[[selectdata]](res)
    res <- steps$excludeoutliers[[excludeoutliers]](res, depen)
    res <- steps$runmodel[[runmodel]](res, depen)
    res <- steps$extraction[[extraction]](res)
    
    return(res)
  }
  
  #---------------
  
  #now iteratively,
  
#make one iteration into a function
  fact<- function(n, b0, b1, b_z, b_d, dep){
    #generate data
    dataset <- dgm(n, b0, b1, b_z, b_d)
    
    #run factorial analysis on data
    results <- purrr::pmap(combos[names(steps)], 
                           combinations, 
                           data = dataset, 
                           dependent = dep)
    
    #create output 
    results_df <- cbind((combos %>% select(combo_id)), bind_rows(results))
    
    return(results_df)}
  
#replicate the function
  final <- replicate(iter, fact)

  

  
  #factorial function bracket
  return(final)
}
