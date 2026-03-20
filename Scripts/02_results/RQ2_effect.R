#plot research question 2 effect scenario

rq2.yes.nsig <- nrow(rq2.yes %>% filter(p.value < 0.05))
rq2.yes.plot <- paste0(round(((rq.no.sig)/160*100),1),"%")

rq2.yes.plot <- rbind(w1[1,], c(34, "21.2%", "Opportunistic"))
rq2.yes.plot <- rq2.yes.plot %>% mutate(n.sig.perc = as.numeric(sub("%", "", n.sig.perc)))

ggplot(data = rq2.yes.plot,
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