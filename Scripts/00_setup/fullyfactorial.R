fullyfactorial <- function(iter, n, b0, b1, b_z, b_d, dep){
  
  
#---------------Necessary information ---------------
#create functions for possible steps 
  #For each deviation pattern there are 4 steps
  #1. Select data from dataset (deviate in sample size)
  #2. Remove outlier (deviate in outlier criteria)
  #3. Specify the model (deviate in the statistical model)
  #4. Extract model statistics (same for all)
  
  
  ###Functions for deviations in step 1
  ##Sample size baseline/100%
  ss1 <- function(df){
    ss <- (nrow(df)/1.15)
    df.samplesize <- df %>% slice(1:ss)
    
    return(df.samplesize)
  }
  
  ##Sample size 85%
  ss85 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 0.85
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ##Sample size 97.5%
  ss975 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 0.975
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ##Sample size 1.025% 
  ss1025 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 1.025
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ##Sample size 115%
  ss115 <- function(df){
    ss <- (nrow(df)/1.15)
    size <- 1.15
    df.samplesize <- df %>% slice(1:(ss*(size)))
    
    return(df.samplesize)
  }
  
  ###Functions for deviations in step 2
  
  ##Outliers based on 3 s.d.
  outz3 <- function(df.samplesize, dep){
    
    df.outlier <- df.samplesize %>% filter(
      .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
      .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
    )
    
    return(df.outlier)
  }
  
  ##Outliers based on 2 s.d.
  outz2 <- function(df.samplesize, dep){
    df.outlier <- df.samplesize
    df.outlier$zscore <- scale(df.samplesize[[dep]])
    df.outlier <- df.outlier %>% filter(between(zscore, -2, 2))
    
    return(df.outlier)
  }
  
  ##Outliers based on Cook's > 1
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
  
  ###Functions for deviations in step 3
  
  ##Baseline model 
  modelyx <- function(df.outlier, dep){
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x, data = df.outlier)
    
    return(reg)
  }
  
  ##Model with continuous covariate
  modelyxz <- function(df.outlier, dep){
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x + z, data = df.outlier)
    
    return(reg)
  }
  
  ##Model with dichotomous covariate
  modelyxd <- function(df.outlier, dep){
    
    y <- df.outlier[[dep]]
    reg <- lm(y~x + d, data = df.outlier)
    
    return(reg)
  }
  
  ##Model with alternative outcome
  modelyax <- function(df.outlier, dep){
    
    ya <- df.outlier[[paste0(dep, "_alt")]]
    reg <- lm(ya ~ x, data = df.outlier)
    
    return(reg)
  }
  
  ###Functions for deviations in step 4
  #extract function
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
  
  #create an 'id' specifying which combination was used
  combos$id <- apply(combos, 1, paste0, collapse = "")
  
#factorial analysis function (perform analysis using one combination)
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
  
  #now iteratively
  #create empty list
  all <- list()
  
  #per iteration: generate data, run factorial analysis, save output
  for (i in 1:iter){
  
  #generate data
  dataset <- dgm(n, b0, b1, b_z, b_d)
  
  #run analysis using each possible combination of steps
  results <- purrr::pmap(combos[names(steps)], 
                         combinations, 
                         data = dataset, 
                         dependent = dep)
  
  #create output (id and model output)
  results_df <- cbind((combos %>% select(id)), bind_rows(results))
  
  #save output 
  all[[i]] <- results_df
  
  }
  
  #output of function gives long df with additional column for iteration
  final <- bind_rows(all, .id = "iteration")
  
  return(final)
}



