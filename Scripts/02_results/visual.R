q <- analysis(160,200,0,0,0,0,"y_no")

w1 <- nsig(q)
w <- nsig(q)
w$conditions <- factor(w$conditions, levels = w$conditions)
w$domain <-c("Baseline","Sample size","Sample size","Sample size","Sample size","Outlier exclusion criteria","Outlier exclusion criteria","Statistical model","Statistical model","Statistical model")
w$domain <- factor(w$domain, levels = c("Baseline", "Sample size","Outlier exclusion criteria","Statistical model"))


ggplot(data = w,
       mapping = aes(x = conditions, y = n.sig.perc, fill = domain)) +
  geom_bar(stat = "identity") +
  #labels
  xlab("Simulation conditions") +
  ylab("Significant p-values (%)") +
  scale_fill_discrete(name = "Domains") +
  #x-axis
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.line.x.bottom = element_line(linewidth = 0.75))+
  #y-axis
  theme(axis.title.y = element_text(margin =  margin(r=20)),
        axis.line.y = element_line(linewidth = 0.75)) +
  #legend
  theme(legend.position = "top",
        legend.title = element_text(size = 15,
                                    margin = margin(r=20)),
        legend.key.size = unit(0.5, "cm")) +
  #horizontal line
  geom_hline(yintercept = "5%", 
             color = "red", 
             linewidth = 0.5)
        
#if i want to change the colors
#  scale_fill_manual(values = c(
#   "Baseline" = ,
#   "Sample size" = ,
#   "Outlier exclusion criteria" = ,
#   "Statistical model" = 
# ))



##RQ2

e <- choice(q)
e1 <- nrow(e %>% filter(p.value < 0.05))
e2 <- paste0(round(((e1)/160*100),1),"%")

rq2_no_plot <- rbind(w1[1,], c(34, "21.2%", "Opportunistic"))
rq2_no_plot <- rq2_no_plot %>% mutate(n.sig.perc = as.numeric(sub("%", "", n.sig.perc)))

ggplot(data = rq2_no_plot,
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
