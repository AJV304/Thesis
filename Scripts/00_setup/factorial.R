#Data generate 
df <- dgm(200,0,0,0,0)

#Data select

##do 
ss1 <- function(df){
ss <- (nrow(df)/1.15)
df.samplesize <- df %>% slice(1:ss)

return(df.samplesize)
}

## or 
ss85 <- function(df){
ss <- (nrow(df)/1.15)
size <- 0.85
df.samplesize <- df %>% slice(1:(ss*(size)))

return(df.samplesize)
}

## or
ss975 <- function(df){
ss <- (nrow(df)/1.15)
size <- 0.975
df.samplesize <- df %>% slice(1:(ss*(size)))

return(df.samplesize)
}

## or 
ss1025 <- function(df){
ss <- (nrow(df)/1.15)
size <- 1.025
df.samplesize <- df %>% slice(1:(ss*(size)))

return(df.samplesize)
}

## or
ss115 <- function(df){
ss <- (nrow(df)/1.15)
size <- 1.15
df.samplesize <- df %>% slice(1:(ss*(size)))

return(df.samplesize)
}

#outlier

## do
outz3 <- function(df.samplesize, dep){
  
df.outlier <- df.samplesize %>% filter(
  .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
  .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
)

return(df.outlier)
}

## or
outz2 <- function(df.samplesize, dep){
df.outlier <- df.samplesize
df.outlier$zscore <- scale(df.samplesize[[dep]])
df.outlier <- df.outlier %>% filter(between(zscore, -2, 2))

return(df.outlier)
}

## or
outc1 <- function(df.samplesize, dep){
  
df.outlier <- df.samplesize %>% filter(
  .data[[dep]] >= mean(.data[[dep]]) - 3*sd(.data[[dep]]),
  .data[[dep]] <= mean(.data[[dep]]) + 3*sd(.data[[dep]])
)

y <- df.outlier[[dep]]
reg <- lm(y~x, data = df.outlier)

df.outlier$cook <- cooks.distance(reg)
df.outlier <- df.outlier %>% filter(between(cook, 0, 1))

return(df.outlier)
}

#model

## do
modelyx <- function(df.outlier, dep){
  
y <- df.outlier[[dep]]
reg <- lm(y~x, data = df.outlier)

return(reg)
}

## or
modelyxz <- function(df.outlier, dep){
  
y <- df.outlier[[dep]]
reg <- lm(y~x + z, data = df.outlier)

return(reg)
}

## or
modelyxd <- function(df.outlier, dep){
  
y <- df.outlier[[dep]]
reg <- lm(y~x + d, data = df.outlier)

return(reg)
}

## or
modelyax <- function(df.outlier, dep){
  
ya <- df.outlier[[paste0(dep, "_alt")]]
reg <- lm(ya ~ x, data = df.outlier)

return(reg)
}

#extract data 
ext <- function(reg){
  
result <- extr(reg) 

return(result)
}
