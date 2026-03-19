q <- analysis(160,200,0,0,0,0,"y_no")
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
  geom_hline(yintercept = "45%", 
             color = "red", 
             linewidth = 1)
        
#if i want to change the colors
#  scale_fill_manual(values = c(
#   "Baseline" = ,
#   "Sample size" = ,
#   "Outlier exclusion criteria" = ,
#   "Statistical model" = 
# ))