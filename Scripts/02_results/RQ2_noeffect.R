#plot research question 2 no effect scenario

rq2.no.nsig <- nrow(rq2.no %>% filter(p.value < 0.05))
rq2.no.perc <- round(((rq2.no.nsig)/nrow(rq2.no)),3)
rq2.no.num <- as.numeric(sub("%", "", rq2.no.perc))


rq2.no.plot <- rbind(rq1.no.plot[1,], c(rq2.no.nsig, rq2.no.num,"Opportunistic", "Opportunistic"))
rq2.no.plot <- rq2.no.plot %>% mutate(n.sig.perc = as.numeric(sub("%", "", n.sig.perc)))

rq2.no.table <- table(rq2.no$n.sig)

#plot
ggplot(data = rq2.no.plot,
       mapping = aes(x = conditions, y = n.sig.perc, fill = conditions)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  #labels
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
