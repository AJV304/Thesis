#-------------------------------


#generate data
?rnorm
?t.test

x <- rnorm(n = 1000,
           mean = 0,
           sd = 1)

hist(x)
t.test(x)
t <- t.test(x)

#generate data iteratively
set.seed(2222)
repl <- 10000
p.val <- numeric(repl)

#generate 10000 data sets and for each one calculate the p-value of a t-test
for (i in 1:repl) {
  x <- rnorm(n = 150, mean = 0, sd = 1)
  p.val[i] <- t.test(x)$p.value
}

#histogram of the p-values, we expect it to be equally distributed. A flat graph
#which it is. 
hist(p.val)

# we expect about 0.05*10000 (500) cases to fall below 0.05 in p-value. Which is
# about accurate. 483 cases are below 0.05
sigp <- p.val[p.val<0.05]
hist(sigp)


##Now a case where the H0 is not true
set.seed(2222)
repl <- 10000
p.val2 <- numeric(repl)

#generate 10000 data sets and for each one calculate the p-value of a t-test
for (i in 1:repl) {
  x <- rnorm(n = 150, mean = 0.5, sd = 1)
  p.val2[i] <- t.test(x)$p.value
}

#histogram of the p-values, we expect all p-values to be very low since the
#null-hypothesis is not true.
hist(p.val2)

# the number of insignificant p-values should be very low since the
# null-hypothesis is not true. In this case only 1/10000 cases was deemed
# significant.
insigp2 <- p.val2[p.val2>0.05]
hist(insigp2)

#----------------------------------------------------------------------------

#simulate regression data

  #create independent variable
x <- rnorm(n = 100,
           mean = 10,
           sd = 1)
  #create error
re <- rnorm(n = 100, mean = 0, sd = 1)
  #create regression formula
y <- 5 + 0.45*x + re
  #calculate regression coefficients
lm <- summary(lm(y~x))
  #request p-value
lm$coefficients[2,4]


#now make it iteratively
rep <- 1000
pval <- numeric(rep)

for (i in 1:rep) {
  #create independent variable
  x <- rnorm(n = 100,
             mean = 10,
             sd = 1)
  #create error
  re <- rnorm(n = 100, mean = 0, sd = 1)
  #create regression formula
  y <- 5 + 0.45*x + re
  #calculate regression coefficients
  lm <- summary(lm(y~x))
  #request p-value
  pval[i] <- lm$coefficients[2,4]
}

#we have a model that is significant so we expect a lot of the p-values to be
#under 0.05 which is indeed the case
hist(pval)


#now let's do the same for a scenario in which there is no effect 

for (i in 1:rep) {
  #create independent variable
  x <- rnorm(n = 100,
             mean = 10,
             sd = 1)
  #create independent variable
  y <- rnorm(n = 100,
             mean = 15,
             sd = 1)
  #calculate regression coefficients
  lm <- summary(lm(y~x))
  #request p-value
  pval[i] <- lm$coefficients[2,4]
}

#there should be no effect so we would hope that the p-values are equally
#distributed and that 50 cases are under 0.05
hist(pval)

#cases under 0.05, 52 cases
sigp <- pval[pval<.05]


#--------------------------------------------------------------------

#now how would it work if we were to vary the sample size of the data sets

samplesize <- c(1, 1.1, 1.5, 2)
ss <- length(samplesize)
rep <- 1000
n <- 150
pval <- data.frame(matrix(ncol = ss, nrow = rep))


for (p in 1:ss){
  n.new <- n*samplesize[p]
  
  for (i in 1:rep) {
    #create independent variable
    x <- rnorm(n = n.new,
               mean = 10,
               sd = 1)
    #create independent variable
    y <- rnorm(n = n.new,
               mean = 15,
               sd = 1)
    #calculate regression coefficients
    lm <- summary(lm(y~x))
    #request p-value of this iteration in the ith place and the pth column
    pval[i,p] <- lm$coefficients[2,4]
  }

}

#look at how many significant p-values in each test
library(dplyr)
s.p.x1 <- pval %>% select(X1) %>% filter(X1 < 0.05)
hist(pval[,1], xlim = c(0,0.1), ylim = c(0, 100), breaks = 100)

s.p.x2 <- pval %>% select(X2) %>% filter(X2 < 0.05)
hist(pval[,2], xlim = c(0,0.1), ylim = c(0, 100), breaks = 100)

s.p.x3 <- pval %>% select(X3) %>% filter(X3 < 0.05)
hist(pval[,3], xlim = c(0,0.1), ylim = c(0, 100), breaks = 100)

s.p.x4 <- pval %>% select(X4) %>% filter(X4 < 0.05)
hist(pval[,4], xlim = c(0,0.1), ylim = c(0, 100), breaks = 100)


#--------------------------------------------------------------

#Little testy test to see if I can use the same data for regression as
#t-test/anova
n <- 500

x <- c(0,1)
group <- sample(x, n, replace= TRUE)

y <- rnorm(n, mean = 0, sd = 1)

df <- data.frame(y,group)

w <- df %>% filter(group == 1)
m <- df %>% filter(group == 0)

t.test(x = w, y = m)
summary(lm(y ~ group, data = df))
model <- lm(y ~ group, data = df)
anova(model)

#---------------------------------------------------------------
n = 1000
x <- c(0,1,2)
group <- sample(x, n, replace= TRUE)

y <- rnorm(n, mean = 0, sd = 1)

df <- data.frame(y,group)

w <- df %>% filter(group == 1)
m <- df %>% filter(group == 0)
nb <- df %>% filter(group == 2)

t.test(w,m)
t.test(w,nb)
t.test(x = m, y = nb)
summary(lm(y ~ group, data = df))
model <- lm(y ~ group, data = df)
anova(model)
#conclusion, which I expected, ANOVA and regression are the exact same this way.
#In Type I and Type II error
#'problematic' is that the t-test keeps showing significant results when the
#data have been simulated independently, I SPECIFIED THE WRONG VARIABLE, I
#SELECTED THE DATAFRAME FOR EACH GROUP AS VARIABLE BUT DIDN'T SPECIFY TO COMPARE
#THE Y VARIABLE LOL

#-------------------------------------------------------------------
#Examine it iteratively

n = 100
x <- c(0,1,2)
rep <- 1000
p <- data.frame(matrix(ncol = length(x), nrow = 1000))


for (i in 1:rep){
  
  #generate data, group variable, numerical variable and make dataframe
  group <- sample(x, n, replace= TRUE)
  y <- rnorm(n, mean = 0, sd = 1)
  df <- data.frame(y,group)
  
  #for each group make own data set
  m <- df %>% filter(group == 0)
  w <- df %>% filter(group == 1)
  nb <- df %>% filter(group == 2)
  
  #perform t-test comparing each group and save p-values
  p[i,1]<- t.test(w$y,m$y)$p.value
  p[i,2] <- t.test(w$y,nb$y)$p.value
  p[i,3] <- t.test(x = m$y, y = nb$y)$p.value
  
}

hist(p$X1)
hist(p$X2)
hist(p$X3)

#----------------------------------
#outlier detection 

#simulate regression data
  #create independent variable
x <- rnorm(n = 100,
           mean = 10,
           sd = 1)
  #create error
re <- rnorm(n = 100, mean = 0, sd = 1)
  #create regression formula
y <- 5 + 0.25*x + re
  #create data frame
df <- data.frame(x,y)
  
#perform regression
reg <- lm(y~x)
regsum <- summary(lm(y~x))
# #request p-value
lm$coefficients[2,4]

#examine outliers based on z
df$z <- scale(y)
df.ex.z <- df %>% filter(between(z, -3, 3))

df$cook <- cooks.distance(reg)
plot(cooks.distance(lm(y~x)))
df.ex.cook <- df %>% filter(between(cook, 0, 1))

#throw in a few weird values to test

#simulate regression data
#create independent variable
x <- rnorm(n = 100,
           mean = 10,
           sd = 1)
x <- append(x, c(20, 40, 60))
#create error
re <- rnorm(n = 103, mean = 0, sd = 1)
#create regression formula
y <- 5 + 0.25*x + re
#create data frame
df <- data.frame(x,y)

#perform regression
reg <- lm(y~x)
regsum <- summary(lm(y~x))
# #request p-value
# lm$coefficients[2,4]

#examine outliers based on z
df$z <- scale(y)
df.ex.z <- df %>% filter(between(z, -3, 3))

df$cook <- cooks.distance(reg)
plot(cooks.distance(lm(y~x)))
df.ex.cook <- df %>% filter(between(cook, 0, 1))
#okay it does seem to work but I am not sure how we will generate data that
#naturally has outliers to make sure there even is a comparison to be made, ask Hanne

#----------------------
#now iteratively
#effect scenario (ha = t)
set.seed(1979094)

n <- 100
rep <- 1000
#empty dataframe to save the number of outliers per method
excl <- data.frame(matrix(ncol = 2, nrow = rep))
#empty dataframe to save p-value of regression for each outlier method
pval <- data.frame(matrix(ncol = 3, nrow = rep))

#loop a regression for each data set without outliers based on 3 criteria
for (i in 1:rep){
  
  x <- rnorm(n = n,
             mean = 10,
             sd = 1)
  #add some potential outliers manually
  x <- append(x, c(20, 40, 60))
  #create error
  re <- rnorm(n = 103, mean = 0, sd = 1)
  #create regression formula
  y <- 5 + 0.25*x + re
  #create data frame
  df <- data.frame(x,y)
  
  #perform regression for the NO OUTLIERS condition
  reg <- lm(y~x)
  regsum <- summary(lm(y~x))
  pval[i,1] <- regsum$coefficients[2,4]
  
  #examine the number of outliers based on z-score
  df$z <- scale(y)
  df.ex.z <- df %>% filter(between(z, -3, 3))
  #save how many cases are deleted
  excl[i,1] <- nrow(df) - nrow(df.ex.z)
  
  #now do the same for cook's
  df$cook <- cooks.distance(reg)
  df.ex.cook <- df %>% filter(between(cook, 0, 1))
  excl[i,2] <- nrow(df) - nrow(df.ex.cook)
  
  #perform regression for the Z-SCORE condtion
  reg.ex.z <- lm(y~x, data = df.ex.z)
  regsum.ex.z <- summary(reg.ex.z)
  pval[i,2] <- regsum.ex.z$coefficients[2,4]
  
  #perform regression for the COOK'S condition
  reg.ex.cook <- lm(y~x, data = df.ex.cook)
  regsum.ex.cook <- summary(reg.ex.cook)
  pval[i,3] <- regsum.ex.cook$coefficients[2,4]
  
}

table(excl[,1]) #amount of outliers removed using z
table(excl[,2]) #amount of outliers removed using cook

#create a table that shows how many outliers are removed in the z-score and cook
#conditions
excl.table <- cbind(
  v1 = table(factor(excl[,1], levels = c(0,1,2,3))),
  v2 = table(factor(excl[,2], levels = c(0,1,2,3)))
                    )
#add columns names
colnames(excl.table) <- c("Z-scores", "Cook's")
excl.table

#how do the pvalues compare for each method
summary(pval)

#graphically display differences in p-values
  #transform to long format
df_long <- pval %>%
  select("No exclusion" = 1, "Z-score" = 2, "Cook's" = 3) %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value")
  #create graph
ggplot(df_long, aes(x = value, fill = variable)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  theme_minimal() +
  labs(
    title = "P-values after exclusion",
    x = "P-value",
    y = "Count",
    fill = "Variable"
  )

#counting the amount of observations <.05 for each condition
#what does apply do: to pval df, in the columns, count any value <0.05
sig.p.values <- apply(pval, 2, function(x) sum(x < .05))
sig.p.values <- matrix(sig.p.values, nrow = 1)
colnames(sig.p.values) <- c("No exclusion", "Z-score", "Cook's")
sig.p.values

#interesting, this was the effect scenario, and the exclusion of the extreme
#data points through z-scores actually made the research less likely to find the
#effect

#---------------------------
#no effect scenario
#H0= t

set.seed(1979094)

#set certain values
n <- 100
rep <- 1000
#empty dataframe to save the number of outliers per method
excl <- data.frame(matrix(ncol = 2, nrow = rep))
#empty dataframe to save p-value of regression for each outlier method
pval <- data.frame(matrix(ncol = 3, nrow = rep))





for (i in 1:rep){
  
  x <- rnorm(n = n,
             mean = 10,
             sd = 1)
  x <- append(x, c(20, 40, 60))
  #create error
  re <- rnorm(n = 103, mean = 0, sd = 1)
  #create regression formula
  y <- 5 + 0*x + re
  #create data frame
  df <- data.frame(x,y)
  
  #perform regression
  reg <- lm(y~x)
  regsum <- summary(lm(y~x))
  pval[i,1] <- regsum$coefficients[2,4]
  
  #examine outliers based on z
  df$z <- scale(y)
  df.ex.z <- df %>% filter(between(z, -3, 3))
  #save how many cases are deleted
  excl[i,1] <- nrow(df) - nrow(df.ex.z)
  
  df$cook <- cooks.distance(reg)
  df.ex.cook <- df %>% filter(between(cook, 0, 1))
  excl[i,2] <- nrow(df) - nrow(df.ex.cook)
  
  #perform regression without z outliers
  reg.ex.z <- lm(y~x, data = df.ex.z)
  regsum.ex.z <- summary(reg.ex.z)
  pval[i,2] <- regsum.ex.z$coefficients[2,4]
  
  #perform regression without cook outliers
  reg.ex.cook <- lm(y~x, data = df.ex.cook)
  regsum.ex.cook <- summary(reg.ex.cook)
  pval[i,3] <- regsum.ex.cook$coefficients[2,4]
  
}


excl.table <- cbind(
  v1 = table(factor(excl[,1], levels = c(0,1,2,3))),
  v2 = table(factor(excl[,2], levels = c(0,1,2,3)))
)

colnames(excl.table) <- c("Z-scores", "Cook's")
excl.table

#graphically display differences in p-values
summary(pval)

df_long <- pval %>%
  select("No exclusion" = 1, "Z-score" = 2, "Cook's" = 3) %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value")

ggplot(df_long, aes(x = value, fill = variable)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  theme_minimal() +
  labs(
    title = "P-values after exclusion",
    x = "P-value",
    y = "Count",
    fill = "Variable"
  )
#interestingly in the no effect scenario, cook's criteria seems to result in an
#inflated type I error

#none
ggplot(pval, aes(x = X1)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  ylim(c(0, 40)) +
  theme_minimal() +
  labs(
    title = "P-values without exclusion",
    x = "P-value",
    y = "Count",
  )

#Zscores
ggplot(pval, aes(x = X2)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  ylim(c(0, 40)) +
  theme_minimal() +
  labs(
    title = "Z-score p-values after exclusion",
    x = "P-value",
    y = "Count",
  )

#cook's
ggplot(pval, aes(x = X3)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  ylim(c(0, 40)) +
  theme_minimal() +
  labs(
    title = "Cook's p-values after exclusion",
    x = "P-value",
    y = "Count",
  )


#tabular overview of <.05 cases
apply(pval, 2, function(x) sum(x < .05))
#as stated before, it seems that cook's has an inflated type I error





#HUH I ALREADY DID THIS, WHY DID I REPEAT IT BELOW???
#now look at p-values for each method with an effect
n <- 100
rep <- 1000
#empty dataframe to save the number of outliers per method
excl <- data.frame(matrix(ncol = 2, nrow = rep))
#empty dataframe to save p-value of regression for each outlier method
pval <- data.frame(matrix(ncol = 3, nrow = rep))

for (i in 1:rep){
  
  x <- rnorm(n = n,
             mean = 10,
             sd = 1)
  x <- append(x, c(20, 40, 60))
  #create error
  re <- rnorm(n = 103, mean = 0, sd = 1)
  #create regression formula
  y <- 5 + 0.25*x + re
  #create data frame
  df <- data.frame(x,y)
  
  #perform regression
  reg <- lm(y~x)
  regsum <- summary(lm(y~x))
  pval[i,1] <- regsum$coefficients[2,4]
  
  #examine outliers based on z
  df$z <- scale(y)
  df.ex.z <- df %>% filter(between(z, -3, 3))
  #save how many cases are deleted
  excl[i,1] <- nrow(df) - nrow(df.ex.z)
  
  df$cook <- cooks.distance(reg)
  df.ex.cook <- df %>% filter(between(cook, 0, 1))
  excl[i,2] <- nrow(df) - nrow(df.ex.cook)
  
  #perform regression without z outliers
  reg.ex.z <- lm(y~x, data = df.ex.z)
  regsum.ex.z <- summary(reg.ex.z)
  pval[i,2] <- regsum.ex.z$coefficients[2,4]
  
  #perform regression without cook outliers
  reg.ex.cook <- lm(y~x, data = df.ex.cook)
  regsum.ex.cook <- summary(reg.ex.cook)
  pval[i,3] <- regsum.ex.cook$coefficients[2,4]
  
}

table(excl[,1]) #amount of outliers removed using z
table(excl[,2]) #amount of outliers removed using cook

excl.table <- cbind(
  v1 = table(factor(excl[,1], levels = c(0,1,2,3))),
  v2 = table(factor(excl[,2], levels = c(0,1,2,3)))
)

colnames(excl.table) <- c("Z-scores", "Cook's")
excl.table
# kable(excl.table, caption = "Outlier exclusion rates")


#graphically display differences in p-values
summary(pval)

df_long <- pval %>%
  select("No exclusion" = 1, "Z-score" = 2, "Cook's" = 3) %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value")

ggplot(df_long, aes(x = value, fill = variable)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  theme_minimal() +
  labs(
    title = "P-values after exclusion",
    x = "P-value",
    y = "Count",
    fill = "Variable"
  )

#separate plots for each since not very viewable when overlapping
#none
ggplot(pval, aes(x = X1)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  ylim(c(0, 1000)) +
  xlim(c(-0.05, 1)) +
  theme_minimal() +
  labs(
    title = "Z-score p-values after exclusion",
    x = "P-value",
    y = "Count",
  )

#Zscores
ggplot(pval, aes(x = X2)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  ylim(c(0, 1000)) +
  xlim(c(-0.05, 1)) +
  theme_minimal() +
  labs(
    title = "Z-score p-values after exclusion",
    x = "P-value",
    y = "Count",
  )

#cook's
ggplot(pval, aes(x = X3)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  coord_cartesian(ylim = c(0, 50), xlim = c(0, 1))+
  theme_minimal() +
  labs(
    title = "Cook's p-values after exclusion",
    x = "P-value",
    y = "Count",
  )


#to pval df, in the columns, count the values <.05
apply(pval, 2, function(x) sum(x < .05))
#and it seems that in the effect situation, z-scores might not detect effects
#as well


#-----------------
#Advanced R practice

c(1,2,3)

dat$x <- as.data.frame(c("hello"))
typeof(df$x)


#----------------
#using my actual dgm

#now iteratively
#effect scenario (h = t)
set.seed(1979094)


rep <- 1000

#empty dataframe to save the number of outliers per method
excl <- data.frame(matrix(ncol = 2, nrow = rep))
#empty dataframe to save p-value of regression for each outlier method
pval <- data.frame(matrix(ncol = 3, nrow = rep))

#loop a regression for each data set without outliers based on 3 criteria
for (i in 1:rep){
  
  df <- dgm_alt()
  
  #perform regression for the NO OUTLIERS condition
  reg <- lm(formula = y_yes~x, data = df)
  regsum <- summary(reg)
  pval[i,1] <- regsum$coefficients[2,4]
  
  #examine the number of outliers based on z-score
  df$z <- scale(df$y_yes)
  df.ex.z <- df %>% filter(between(z, -3, 3))
  #save how many cases are deleted
  excl[i,1] <- nrow(df) - nrow(df.ex.z)
  
  #now do the same for cook's
  df$cook <- cooks.distance(reg)
  df.ex.cook <- df %>% filter(between(cook, 0, 1))
  excl[i,2] <- nrow(df) - nrow(df.ex.cook)
  
  #perform regression for the Z-SCORE condtion
  reg.ex.z <- lm(y_yes~x, data = df.ex.z)
  regsum.ex.z <- summary(reg.ex.z)
  pval[i,2] <- regsum.ex.z$coefficients[2,4]
  
  #perform regression for the COOK'S condition
  reg.ex.cook <- lm(y_yes~x, data = df.ex.cook)
  regsum.ex.cook <- summary(reg.ex.cook)
  pval[i,3] <- regsum.ex.cook$coefficients[2,4]
  
}

table(excl[,1]) #amount of outliers removed using z
table(excl[,2]) #amount of outliers removed using cook

#create a table that shows how many outliers are removed in the z-score and cook
#conditions
excl.table <- cbind(
  v1 = table(factor(excl[,1], levels = c(0,1,2,3))),
  v2 = table(factor(excl[,2], levels = c(0,1,2,3)))
)
#add columns names
colnames(excl.table) <- c("Z-scores", "Cook's")
excl.table

#how do the pvalues compare for each method
summary(pval)

#graphically display differences in p-values
#transform to long format
df_long <- pval %>%
  select("No exclusion" = 1, "Z-score" = 2, "Cook's" = 3) %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value")
#create graph
ggplot(df_long, aes(x = value, fill = variable)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  theme_minimal() +
  labs(
    title = "P-values after exclusion",
    x = "P-value",
    y = "Count",
    fill = "Variable"
  )

#counting the amount of observations <.05 for each condition
#what does apply do: to pval df, in the columns, count any value <0.05
sig.p.values <- apply(pval, 2, function(x) sum(x < .05))
sig.p.values <- matrix(sig.p.values, nrow = 1)
colnames(sig.p.values) <- c("No exclusion", "Z-score", "Cook's")
sig.p.values



#no effect scenario
#no effect scenario (h = f)
set.seed(1979094)


rep <- 1000

#empty dataframe to save the number of outliers per method
excl <- data.frame(matrix(ncol = 2, nrow = rep))
#empty dataframe to save p-value of regression for each outlier method
pval <- data.frame(matrix(ncol = 3, nrow = rep))

#loop a regression for each data set without outliers based on 3 criteria
for (i in 1:rep){
  
  df <- dgm_alt()
  
  #perform regression for the NO OUTLIERS condition
  reg <- lm(formula = y_no~x, data = df)
  regsum <- summary(reg)
  pval[i,1] <- regsum$coefficients[2,4]
  
  #examine the number of outliers based on z-score
  df$z <- scale(df$y_no)
  df.ex.z <- df %>% filter(between(z, -3, 3))
  #save how many cases are deleted
  excl[i,1] <- nrow(df) - nrow(df.ex.z)
  
  #now do the same for cook's
  df$cook <- cooks.distance(reg)
  df.ex.cook <- df %>% filter(between(cook, 0, 4/nrow(df)))
  excl[i,2] <- nrow(df) - nrow(df.ex.cook)
  
  #perform regression for the Z-SCORE condtion
  reg.ex.z <- lm(y_no~x, data = df.ex.z)
  regsum.ex.z <- summary(reg.ex.z)
  pval[i,2] <- regsum.ex.z$coefficients[2,4]
  
  #perform regression for the COOK'S condition
  reg.ex.cook <- lm(y_no~x, data = df.ex.cook)
  regsum.ex.cook <- summary(reg.ex.cook)
  pval[i,3] <- regsum.ex.cook$coefficients[2,4]
  
}

table(excl[,1]) #amount of outliers removed using z
table(excl[,2]) #amount of outliers removed using cook

#create a table that shows how many outliers are removed in the z-score and cook
#conditions
excl.table <- cbind(
  v1 = table(factor(excl[,1], levels = c(0,1,2,3))),
  v2 = table(factor(excl[,2], levels = c(0,1,2,3)))
)
#add columns names
colnames(excl.table) <- c("Z-scores", "Cook's")
excl.table

#how do the pvalues compare for each method
summary(pval)

#graphically display differences in p-values
#transform to long format
df_long <- pval %>%
  select("No exclusion" = 1, "Z-score" = 2, "Cook's" = 3) %>%
  pivot_longer(cols = everything(),
               names_to = "variable",
               values_to = "value")
#create graph
ggplot(df_long, aes(x = value, fill = variable)) +
  geom_histogram(position = "identity", alpha = 0.7, bins = 50) +
  scale_fill_brewer(palette = "Set1") +
  geom_vline(xintercept = 0.05, color = "red", size = 0.1) +
  theme_minimal() +
  labs(
    title = "P-values after exclusion",
    x = "P-value",
    y = "Count",
    fill = "Variable"
  )

#counting the amount of observations <.05 for each condition
#what does apply do: to pval df, in the columns, count any value <0.05
sig.p.values <- apply(pval, 2, function(x) sum(x < .05))
sig.p.values <- matrix(sig.p.values, nrow = 1)
colnames(sig.p.values) <- c("No exclusion", "Z-score", "Cook's")
sig.p.values
