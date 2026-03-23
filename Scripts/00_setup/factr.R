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



# all index combinations
n_opts <- sapply(steps, length)
combos <- expand.grid(lapply(n_opts, seq_len))
names(combos) <- names(steps)
combos$combo_id <- apply(combos, 1, paste0, collapse = "")


#option 2

run_pipeline <- function(selectdata, excludeoutliers, runmodel, extraction, data, dependent) {
  
  res <- data
  depen <- dependent
  
  res <- steps$selectdata[[selectdata]](res)
  res <- steps$excludeoutliers[[excludeoutliers]](res, depen)
  res <- steps$runmodel[[runmodel]](res, depen)
  res <- steps$extraction[[extraction]](res)
  
  return(res)
}

dataset <- dgm(200, 0,0,0,0)
results <- purrr::pmap(combos[names(steps)], run_pipeline, data = dataset, dependent = "y_no")
results_df <- cbind((combos %>% select(combo_id)), bind_rows(results))

