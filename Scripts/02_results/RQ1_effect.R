#Creating a plot for research question 1 in the effect scenario

#Count the number of significant p-values per condition
rq1.yes.plot <- nsig(rq1.yes)

#Change conditions to a factor in order to plot it
rq1.yes.plot$conditions <- factor(rq1.yes.plot$conditions, levels = rq1.yes.plot$conditions)

#Add a 'domain' variable to group the conditions
rq1.yes.plot$domain <-c("Baseline","Sample Size","Sample Size","Sample Size","Sample Size","Outlier Exclusion Criteria","Outlier Exclusion Criteria","Statistical Model","Statistical Model","Statistical Model")
rq1.yes.plot$domain <- factor(rq1.yes.plot$domain, levels = c("Baseline", "Sample Size","Outlier Exclusion Criteria","Statistical Model"))


#Create a plot with 
# -conditions on the x-axis
# -percentage of significant values on the y-axis (power)
# -grouped by color per domain

plot.1y <- ggplot(data = rq1.yes.plot,
       mapping = aes(x = conditions, y = n.sig.perc, fill = domain)) +
  #precision interval
  geom_rect(
    xmin = -Inf, xmax = Inf,
    ymin = 0.79, ymax = 0.81,
    fill = "lightblue",
    alpha = 0.1
  ) +
  geom_bar(stat = "identity", width = 0.75) +
  #labels
  xlab("Simulation conditions") +
  ylab("Significant p-values (%)") +
  scale_fill_discrete(name = "Domains") +
  #y-axis breaks
  scale_y_continuous(labels = percent, 
                     breaks = seq(0,1, 0.2),
                     expand = expansion(mult = c(0, 0.05)))+
  #x-axis
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        axis.line.x.bottom = element_line(linewidth = 0.75))+
  #y-axis
  theme(axis.title.y = element_text(margin =  margin(r=20)),
        axis.line.y = element_line(linewidth = 0.75)) +
  #background
  theme_bw() +
  theme(panel.border = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) +
  #legend
  theme(legend.position = "top",
        legend.title = element_text(size = 15,
                                    margin = margin(r=20)),
        legend.key.size = unit(0.5, "cm"),
        ) +
  #horizontal line
  geom_hline(yintercept = 0.8, 
             color = "red", 
             linewidth = 0.5) +
  coord_flip() +
  scale_x_discrete(limits = rev)

