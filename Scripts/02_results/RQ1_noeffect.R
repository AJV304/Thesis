#Creating a plot for research question 1 in the no-effect scenario

#Count the number of significant p-values per condition
rq1.no.plot <- nsig(rq1.no)

#Change conditions to a factor in order to plot it
rq1.no.plot$conditions <- factor(rq1.no.plot$conditions, levels = rq1.no.plot$conditions)

#Add a 'domain' variable to group the conditions
rq1.no.plot$domain <-c("Baseline","Sample size","Sample size","Sample size","Sample size","Outlier exclusion criteria","Outlier exclusion criteria","Statistical model","Statistical model","Statistical model")
rq1.no.plot$domain <- factor(rq1.no.plot$domain, levels = c("Baseline", "Sample size","Outlier exclusion criteria","Statistical model"))

#Create a plot with 
# -conditions on the x-axis
# -percentage of significant values on the y-axis (type I error)
# -grouped by color per domain
plot.1n <- ggplot(data = rq1.no.plot,
       mapping = aes(x = conditions, y = n.sig.perc, fill = domain)) +
  #precision interval
  geom_rect(
    xmin = -Inf, xmax = Inf,
    ymin = 0.045, ymax = 0.055,
    fill = "lightblue",
    alpha = 0.1
  ) + 
  geom_bar(stat = "identity", width = 0.75) +
  #labels
  xlab("Simulation conditions") +
  ylab("Significant p-values (%)") +
  scale_fill_discrete(name = "Domains") +
  #y-axis range
  scale_y_continuous(labels = percent, 
                     breaks = seq(0,0.1, 0.01),
                     expand = expansion(mult = c(0, 0.1)))+
  #x-axis
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.line.x.bottom = element_line(linewidth = 0.75))+
  #y-axis
  theme(axis.title.y = element_text(margin =  margin(r=20)),
        axis.line.y = element_line(linewidth = 0.75)) +
  #background
  theme_bw() +
  #legend
  theme(legend.position = "top",
        legend.title = element_text(size = 15,
                                    margin = margin(r=20)),
        legend.key.size = unit(0.5, "cm"),
        panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) +
  #horizontal line
  geom_hline(yintercept = 0.05, 
             color = "red", 
             linewidth = 0.5) +
  coord_flip() +
  scale_x_discrete(limits = rev)
