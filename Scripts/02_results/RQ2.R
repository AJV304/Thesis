#plot research question 2 effect scenario

rq2.yes.nsig <- nrow(rq2.yes %>% filter(p.value < 0.05))
rq2.yes.nsig.perc <- (round((rq2.yes.nsig)/nrow(rq2.yes),3))

#number of significant deviations
counts <- table(rq2.yes$n.sig)
percentages <- paste0((round(as.numeric(prop.table(counts)) * 100, 1)), "%")
fin <- paste0(counts, " (", percentages, ")" )
sig <- names(counts)

# Combine into matrix and transpose
rq2.yes.table <- rbind(
  Significant = sig,
  Occurences = fin
)

# Convert to data frame so we can add a "Number" column
rq2.yes.table <- t(as.data.frame(rq2.yes.table))


### Repeat the same steps for the no effect scenario
#plot research question 2 no effect scenario

rq2.no.nsig <- nrow(rq2.no %>% filter(p.value < 0.05))
rq2.no.perc <- round(((rq2.no.nsig)/nrow(rq2.no)),3)

#number of significant deviations
rq2.no.counts <- table(rq2.no$n.sig)
rq2.no.percentages <- paste0((round(as.numeric(prop.table(rq2.no.counts)) * 100, 1)), "%")

rq2.no.fin <- paste0(rq2.no.counts, " (", rq2.no.percentages, ")" )
sig2 <- names(rq2.no.counts)


# Combine into matrix and transpose
rq2.no.table <- rbind(
  Significant = sig2,
  Occurences = rq2.no.fin
)

# Convert to data frame so we can add a "Number" column
rq2.no.table <- t(as.data.frame(rq2.no.table, check.names = FALSE))



#Now combine both scenarios
rq2.table <- merge(rq2.yes.table, rq2.no.table, by = "Significant", all = TRUE)

rq2.table[rq2.table$Significant == "NA", "Significant"] <- "Baseline significant"
rq2.table[is.na(rq2.table$Occurences.y), "Occurences.y"] <- "0 (0%)"
