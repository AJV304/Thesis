#generating the data set with a seed
set.seed(1979094)
df <- analysis(1600, 200, 0, 0.2, 0.06, 0.06)

#The no-effect scenario
rq1.no <- df %>% filter(scenario == "no effect")
rq2.no <- choice(rq1.no)

#The effect scenario
rq1.yes <- df %>% filter(scenario == "effect")
rq2.yes <- choice(rq1.yes)