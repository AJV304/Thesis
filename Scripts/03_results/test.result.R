test <- thesis(iter = 5, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no")
test


#benchmark to see how long one iteration takes
microbenchmark(thesis(iter = 1, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no") , times = 100, unit = "s")

#examining power levels
test <- thesis(iter = 1000, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_yes")
test

powertest <- test[startsWith(rownames(test), "Baseline"), ]

p <- powertest %>% filter(p.value < 0.05)
summary(test$p.value)

type1test <- testNO[startsWith(rownames(test), "Baseline"),]
pNO <- type1test %>% filter(p.value > 0.05)
summary(type1test$p.value)
