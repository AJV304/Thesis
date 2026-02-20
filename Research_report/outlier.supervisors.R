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
