#plot research question 2 effect scenario

rq2.yes.nsig <- nrow(rq2.yes %>% filter(p.value < 0.05))
rq2.yes.nsig.perc <- (round((rq2.yes.nsig)/nrow(rq2.yes),3))


rq2.yes.plot <- rq1.yes.plot[1,]
levels(rq2.yes.plot$domain) <- c(levels(rq2.yes.plot$domain), "Opportunistic")
levels(rq2.yes.plot$conditions) <- c(levels(rq2.yes.plot$conditions), "Opportunistic")
rq2.yes.plot[2,] <- c(rq2.yes.nsig, rq2.yes.nsig.perc, "Opportunistic", "Opportunistic")
rq2.yes.plot$n.sig.perc <- as.numeric(rq2.yes.plot$n.sig.perc )

#number of significant deviations
counts <- table(rq2.yes$n.sig)
percentages <- prop.table(counts) * 100

# Combine into matrix and transpose
rq2.yes.table <- rbind(
  Count = counts,
  Percentage = paste0((round(as.numeric(percentages), 1)), "%")
)

# Create matrix with Count and Percentage
rq2.yes.table <- rbind(
  Count = counts,
  Percentage = round(percentages, 2)
)

# Convert to data frame so we can add a "Number" column
rq2.yes.table <- as.data.frame(rq2.yes.table, check.names = FALSE)

# Add the label column as the first column
rq2.yes.table <- cbind(
  Significant.deviations = rownames(rq2.yes.table),
  rq2.yes.table
)
rownames(rq2.yes.table) <- NULL
rq2.yes.table




#plot but maybe not necessary
ggplot(data = rq2.yes.plot,
       mapping = aes(x = conditions, y = n.sig.perc, fill = conditions)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  scale_y_continuous(
    labels = percent)+
  xlab("Simulation conditions") +
  ylab("Significant p-values (%)") +
  theme(legend.position = "none") +
  #x-axis
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.line.x.bottom = element_line(linewidth = 0.75))+
  #y-axis
  theme(axis.title.y = element_text(margin =  margin(r=20)),
        axis.line.y = element_line(linewidth = 0.75)) +
  #plot margin
  theme(plot.margin = margin(t = 40, l = 20, r = 20, b = 20))
