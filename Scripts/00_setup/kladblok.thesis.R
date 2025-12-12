#remove everything except my functions (make everything in here into a pakcage? 0.0)
rm(list=setdiff(ls(), c('extr', "dgm", "baseline", "cn", "df", "samplesize", "analysis", "outlier", "model")))

#colnames
cn <- c("b1","p-value","lower ci","upper ci")
