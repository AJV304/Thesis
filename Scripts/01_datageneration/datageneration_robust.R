## Generating data with 10000 iterations

#generating the data set with a seed

#hex string from NIST beacon, 1st of April 09.00 (GMT +2)
beacon <- "DF18AA0067680C4F6B8EE292411ED832A4F6AED9F7D6D51FF65DEA0213D2A3E5
D539E82C0A3F81D6249B6A32D75D802478F6A8C0B76DE9A91BF288002E5CAAEA"

#extract numbers from string
numbers <- as.integer(unlist(regmatches(beacon, gregexpr("[0-9]", beacon))))

#Take the first 10 numbers as seed
seed <- numbers[1:10]

#Setting the seed
set.seed(seed)
df <- analysis(10000, 200, 0, 0.2, 0.06, 0.06)

#Create data set with only the no-effect scenario
rq1.no <- df %>% filter(scenario == "no effect")
#run choice analysis on each iteration
rq2.no <- choice(rq1.no)

#Create data set with only the effect scenario
rq1.yes <- df %>% filter(scenario == "effect")
#run choice analysis on each iteration
rq2.yes <- choice(rq1.yes)
