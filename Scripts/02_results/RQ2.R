## Results for research question 2

#In the effect scenario, percentage of significant p-values (power)
rq2.yes.nsig <- nrow(rq2.yes %>% filter(p.value < 0.05))
rq2.yes.nsig.perc <- (round((rq2.yes.nsig)/nrow(rq2.yes),3))

#In the no-effect scenario, pecentage of significant p-values (type I error)
rq2.no.nsig <- nrow(rq2.no %>% filter(p.value < 0.05))
rq2.no.perc <- round(((rq2.no.nsig)/nrow(rq2.no)),3)


## Create table to display results

#count how often a specific number of significant deviations occurs as count and
#percentage
counts <- table(rq2.yes$n.sig)
percentages <- paste0((round(as.numeric(prop.table(counts)) * 100, 1)), "%")

#combine count and percentage as occurence( %) and save names
fin <- paste0(counts, " (", percentages, ")" )
sig <- names(counts)

#combine into table with the number of significant deviation and their
#occurrence rates
rq2.yes.table <- rbind(
  Significant = sig,
  Occurences = fin
)

#convert to data frame and transpose 
rq2.yes.table <- t(as.data.frame(rq2.yes.table))


#repeat the same steps for the no effect scenario

#count how often a specific number of significant deviations occurs as count and
#percentage
rq2.no.counts <- table(rq2.no$n.sig)
rq2.no.percentages <- paste0((round(as.numeric(prop.table(rq2.no.counts)) * 100, 1)), "%")

#combine count and percentage as occurence( %) and save names
rq2.no.fin <- paste0(rq2.no.counts, " (", rq2.no.percentages, ")" )
sig2 <- names(rq2.no.counts)


#combine into table with the number of significant deviation and their
#occurrence rates
rq2.no.table <- rbind(
  Significant = sig2,
  Occurences = rq2.no.fin
)

#convert to data frame and transpose 
rq2.no.table <- t(as.data.frame(rq2.no.table, check.names = FALSE))

#Now combine both scenarios into 1 table
rq2.table <- merge(rq2.yes.table, rq2.no.table, by = "Significant", all = TRUE)

#In the table
#replace NA by Significant Baseline
#replace missing values with 0
#move last row (Significant baseline) to the top
#remove row names for kable table later
rq2.table[rq2.table$Significant == "NA", "Significant"] <- "(Significant baseline)"
rq2.table[is.na(rq2.table$Occurences.y), "Occurences.y"] <- "0 (0%)"
rq2.table <- rq2.table[c(nrow(rq2.table), 1:(nrow(rq2.table)-1)), ]
rownames(rq2.table) <- NULL

