#remove everything except my functions
rm(list=setdiff(ls(), c('extr', "dgm", "baseline", "cn", "df", "samplesize", "analysis", "outlier", "model")))

#colnames
cn <- c("b1","p-value","lower ci","upper ci")
