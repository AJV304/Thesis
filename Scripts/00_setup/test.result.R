
#benchmark to see how long one iteration takes
microbenchmark(analysis(iter = 1, n = 200,0,0,0,0) , times = 100, unit = "s")
microbenchmark(fullyfactorial(1, 200, 0,0,0,0,"y_no"), times = 100, unit = "s")

#Type 1 test
type1test <- thesis(iter = 1000, n = 230, b0 = 0, b1_yes = 0.2, b_z = 0.06, b_d = 0.06, dep = "y_no")
type1test <- type1test %>% filter(condition == "Baseline")
pNO <- type1test %>% filter(p.value > 0.05)

#Power test
test <- thesis(iter = 1000, n = 230, b0 = 0, b1_yes = 0.2, b_z = 0.06, b_d = 0.06, dep = "y_yes")
powertest <- test %>% filter(condition ==  "Baseline")
p <- powertest %>% filter(p.value < 0.05)





