d <- read.csv("Research/december-2023-glassco-cleaning-report.csv")

library(dplyr)
d <- d %>% filter(Number.of.Cleaning.Events <= 300)
summary(d)
result <- bind_rows(
  d %>% summarise(across(where(is.numeric), ~ max(., na.rm = TRUE) / mean(., na.rm = TRUE))),
  d %>% summarise(across(where(is.numeric), ~ mean(., na.rm = TRUE) / min(., na.rm = TRUE)))
)

result
#max is 2x, 2x, 4.6x, 4x bigger than mean

plot(d$Sunday)
d_num <- d[sapply(d, is.numeric)]
boxplot(d_num)
apply(d_num, 2, hist)


#function to check how much bigger the max is than the mean for each numeric variable
outliercheck <- function(data){
  summary <- summary(data)
  result <- bind_rows(
    data %>% summarise(across(where(is.numeric), ~ max(., na.rm = TRUE) / mean(., na.rm = TRUE))),
    data %>% summarise(across(where(is.numeric), ~ mean(., na.rm = TRUE) / min(., na.rm = TRUE)))
  )
  return(list(summary, result))
}

outliercheck(d)

#load dataset
meat <- read.csv("Research/meat_consumption.csv")

meat1 <- meat %>% filter(SUBJECT == "BEEF", TIME == "2024")
outliercheck(meat1)
#for the beef consumption in 2024, the max value is 31 times bigger than the
#average, and the mean is 4402 times bigger than the minimum value

#alternative
meat2 <- meat %>% filter(LOCATION == "AUS", SUBJECT == "BEEF")
outliercheck(meat2)
#if we do it for one country, one type, across time then the max is 2x bigger
#than mean and the mean is a factor 7 times bigger than the min

boxplot(meat1$Value)
boxplot(meat2$Value)

#another data set
library(haven)
socialsurvey <- read_sas("Research/gss2024.sas7bdat")

socialsurvey1 <- socialsurvey %>% filter(YEAR == "2024") %>% select(WRKSTAT, MARITAL, SIBS, CHILDS, AGE, AGEKDBRN, EDUC)
outliercheck(socialsurvey1)
#sibs and childs are uncapped but often fall between 0-5 and in those the max is
#2-5x as big as the mean, variables like age have a clearer limit. WRKSTAT and
#MARITAL are likert type.
boxplot(socialsurvey1)
boxplot(socialsurvey1$SIBS)
boxplot(socialsurvey1$AGE)
boxplot(socialsurvey1$WRKSTAT)
boxplot(socialsurvey1$MARITAL)
#when looking at boxplots, there are no outliers

#loading data set
vegres <- read.csv("Research/Datafiniti_Vegetarian_and_Vegan_Restaurants.csv")
vegres1 <- vegres %>% select(menus.amountMax, menus.amountMin, priceRangeMin, priceRangeMax)

outliercheck(vegres1)
boxplot(vegres1)

#loading data set
library(readxl)
income <- read_excel("Research/psid.xlsx")

#loading data set
well <- read_dta("Research/kenya_water_filter_public_ca20171108.dta")
well1 <- well %>% select(ecoli_num)
outliercheck(well1)
boxplot(well1)
