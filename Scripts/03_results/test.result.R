test <- thesis(iter = 1000, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no")
test


#benchmark to see how long one iteration takes
microbenchmark(thesis(iter = 1, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no") , times = 100, unit = "s")

#examining power levels
test <- thesis(iter = 1000, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.031, b_z = 0.06, b_d = 0.06, dep = "y_yes")
test04 <- thesis(iter = 1000, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.04, b_z = 0.06, b_d = 0.06, dep = "y_yes")
test035 <- thesis(iter = 1000, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.035, b_z = 0.06, b_d = 0.06, dep = "y_yes")

powertest <- test %>% filter(condition ==  "Baseline")
p <- powertest %>% filter(p.value < 0.05)

powertest <- test04 %>% filter(condition ==  "Baseline")
p <- powertest %>% filter(p.value < 0.05)

powertest <- test035 %>% filter(condition ==  "Baseline")
p <- powertest %>% filter(p.value < 0.05)


#comparison
type1test <- thesis(iter = 1000, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.035, b_z = 0.06, b_d = 0.06, dep = "y_no")


type1test <- type1test %>% filter(condition == "Baseline")
pNO <- type1test %>% filter(p.value > 0.05)



#other
set.seed(5)
test <- thesis(iter = 10, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no")

set.seed(5)
test2 <- thesis(iter = 10, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.3, b_z = 0.06, b_d = 0.06, dep = "y_no")

identical(test, test2)


summary(lm(y_yes ~ x, df))

#
test <- thesis(iter = 100, n = 230, b0 = 0, b1_no = 0, b1_yes = 0.2, b_z = 0.06, b_d = 0.06, dep = "y_yes")
powertest <- test %>% filter(condition ==  "Baseline")
p <- powertest %>% filter(p.value < 0.05)

df <- dgm(n = 230, b0 = 0, b1_no = 0, b1_yes = 0.2, b_z = 0.06, b_d = 0.06)
summary(lm(y_yes ~ x, df))
