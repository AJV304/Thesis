## Robust esults for research question 2

#In the effect scenario, percentage of significant p-values (power)
big.rq2.yes.nsig <- nrow(rq2.yes %>% filter(p.value < 0.05))
big.rq2.yes.nsig.perc <- (round((rq2.yes.nsig)/nrow(rq2.yes),3))

#In the no-effect scenario, pecentage of significant p-values (type I error)
big.rq2.no.nsig <- nrow(rq2.no %>% filter(p.value < 0.05))
big.rq2.no.perc <- round(((rq2.no.nsig)/nrow(rq2.no)),3)