#mock results 

outlier <- data.frame( Type = c("Baseline", "z-score", "cook's distance"),
                       Error = c(0.05, 0.054, 0.074))

ggplot(outlier, aes(x = reorder(Type, Error), y = Error)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
               labs(title = "Type I Error per Outlier Condition", x = "Condition Type", y = "Type I error rate") +
  scale_y_continuous(labels = scales::percent) + 
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red", size = 0.5) +
               theme_minimal()

statmed <- data.frame( Type = c("Baseline", "Dichotomous covariate", "Continuous covariate"),
                       Error = c(0.05, 0.064, 0.060))

ggplot(statmed, aes(x = reorder(Type, Error), y = Error)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  labs(title = "", x = "Condition Type", y = "Type I error rate") +
  scale_y_continuous(labels = scales::percent) + 
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red", size = 0.5) +
  theme_minimal()

statmed2 <- data.frame( Type = c("Baseline", "Switching Outcomes"),
                       Error = c(0.05, 0.058))

ggplot(statmed2, aes(x = reorder(Type, Error), y = Error)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  labs(title = "", x = "Condition Type", y = "Type I error rate") +
  scale_y_continuous(labels = scales::percent) + 
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "red", size = 0.5) +
  theme_minimal()

type2 <- data.frame( Type = c("Baseline", "Sample size +5", "Sample size +30","Sample size -5", "Sample size -30", "Z-score", "Cook's distance", "Adding a Continuous Covariate", "Adding a Dichotomous Covariate", "Outcome change"),
                     Error = c(0.80, 0.83, 0.91, 0.79, 0.75, 0.83, 0.80, 0.77, 0.69, 0.64))
type2$Type <- factor(type2$Type, levels = type2$Type)

ggplot(type2, aes(x = Type, y = Error)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  labs(title = "Power per Condition", x = "Condition", y = "Power") +
  theme(plot.title = element_text(hjust = .5))+
  scale_y_continuous(labels = scales::percent) + 
  geom_hline(yintercept = 0.80, linetype = "dashed", color = "red", size = 0.5) +
  theme_minimal() +
  coord_flip()
  

