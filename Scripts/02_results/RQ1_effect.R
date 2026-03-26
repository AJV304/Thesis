#plot research question 1 effect scenario
rq1.yes.plot <- nsig(rq1.yes)
rq1.yes.plot$conditions <- factor(rq1.yes.plot$conditions, levels = rq1.yes.plot$conditions)
rq1.yes.plot$domain <-c("Baseline","Sample size","Sample size","Sample size","Sample size","Outlier exclusion criteria","Outlier exclusion criteria","Statistical model","Statistical model","Statistical model")
rq1.yes.plot$domain <- factor(rq1.yes.plot$domain, levels = c("Baseline", "Sample size","Outlier exclusion criteria","Statistical model"))

library(scales)

ggplot(data = rq1.yes.plot,
       mapping = aes(x = conditions, y = n.sig.perc, fill = domain)) +
  geom_bar(stat = "identity") +
  #labels
  xlab("Simulation conditions") +
  ylab("Significant p-values (%)") +
  scale_fill_discrete(name = "Domains") +
  scale_y_continuous(labels = percent, 
                     breaks = seq(0,1, 0.2)) +
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
  geom_hline(yintercept = 0.8, 
             color = "red", 
             linewidth = 0.5) +
  geom_rect(
    xmin = -Inf, xmax = Inf,
    ymin = 0.79, ymax = 0.81,
    fill = "lightblue",
    alpha = 0.05
  )
