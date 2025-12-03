#mock results 

outlier <- data.frame( Type = c("Baseline", "z-score", "cook's distance"),
                       Error = c(0.05, 0.054, 0.074))

ggplot(outlier, aes(x = reorder(Type, Error), y = Error)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
               labs(title = "Type I Error per Outlier Condition", x = "Condition Type", y = "Type I error rate") +
  scale_y_continuous(labels = scales::percent) + 
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red", size = 0.5) +
               theme_minimal()
