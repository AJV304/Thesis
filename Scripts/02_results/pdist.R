

pdist <- function(df){

ncond <- length(unique(df$condition))
cond <- unique(df$condition)
his <- NULL

for (i in 1:ncond){
  dat <- df %>% filter(condition == cond[i])
  his[i] <- hist(dat$p.value, main = cond[i])
}

print(his)
}

pdist(rq1.no)
pdist(rq1.yes)
