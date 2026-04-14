mcse <- function(signiter, nsim){
  typeIerror <- signiter/nsim
  mc <- sqrt((typeIerror*(1-typeIerror))/nsim)
  interval <- c((0.05-mc), (0.05+mc))
  check <- typeIerror > min(interval) & typeIerror < max(interval)
  return(check)
}

mcse(92, 1600)
mcse(86, 1600)
mcse(84, 1600)
mcse(83, 1600)
mcse(82, 1600)
mcse(79, 1600)
mcse(76, 1600)
mcse(74, 1600)
