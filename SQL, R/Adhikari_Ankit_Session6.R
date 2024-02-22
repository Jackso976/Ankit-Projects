#Exercise 6.1
#a) Load the whitehouse.csv file. Column types are "ccncci".
library(tidyverse)
types = "ccncci"
whitehouse <- read_csv("whitehouse.csv", col_types = types)

whitehouse
#b) Look at a boxplot of salary data.

boxplot(whitehouse$Salary)
#c) Find salaries over $1,000,000, and set them NA.
whitehouse %>% filter(Salary>1000000)
whitehouse <- whitehouse %>% mutate(Salary=ifelse(Salary>1000000, NA, Salary))
boxplot(whitehouse$Salary)
#d) Rerun the box plot and check your cleaning.
boxplot(whitehouse$Salary)

#Exercise 6.2
#a) Load the testscores.csv file.
tests <- read.csv(("testscores.csv"))
summary(tests)

#b) Look at the data (statistics and boxplot), focus on age.
boxplot(tests$age)

tests %>% filter(age>15)
#c) Investigate outliers and correct the data. Suppose that grade is correct.
tests <- tests %>% 
  mutate(age=ifelse(studentID==10115, 7, age)) %>%
  mutate(age=ifelse(studentID==10116, 12, age))
boxplot(tests$age)
#d) Rerun the box plot and check your cleaning.
boxplot(tests$age)

#e) Check the age by grade.

boxplot(tests$age ~ tests$grade)
#Exercise 6.3
#a) Load the residents.csv file. Column types are "iillll".

types = "iillll"
residents <- read_csv("residents.csv", col_types = types)

#b) Check the summary and try to find unusual cases.

summary(residents)
residents %>% filter((ownsHome==rentsHome)
                     
                     summary(residents) 
#Exercise 6.4 (alone)
#1. Read the immunization data.

immunization <- read_csv("immunization.csv")
immunization
#2. Check the tail of the dataset and remove the unnecessary rows.

tail(immunization) 



#3. Check for missing data and replace them by NA.
immunization[immunization=='..']<-NA 
tail(immunization)

#4. Rename columns and transform them to numeric:
  • ‘Time’ to year,
• ‘Country code’ to c,
• `Population, total [SP.POP.TOTL]` to pop after division by 1,000,000
• `Mortality rate, under-5 (per 1,000 live births) [SH.DYN.MORT]` to mort
• `Immunization, measles (% of children ages 12-23 months) [SH.IMM.MEAS]` to imm
• `GDP per capita, PPP (constant 2011 international $) [NY.GDP.PCAP.PP.KD]` to gdppc

names(immunization) <- c("year", "Time Code", "Country Name", "c", "mort", "imm", "pop", "gdppc") 
immunization$year <- as.numeric(immunization$year) 
immunization$pop <- as.numeric(immunization$pop)/1000000
immunization$mort <- as.numeric(immunization$mort)
immunization$imm <- as.numeric(immunization$imm) 
immunization$gdppc <- as.numeric(immunization$gdppc)
glimpse(immunization)


#5. Create two new numeric variables:
  • surv as (1000-mort)/100
• lngdppc as the logarithm of gdppc

immunization$surv <- (1000 - immunization$mort) / 100
immunization$lngdppc <- log(immunization$gdppc)
view(immunization)
#6. Rename two character-type variables:
  • ‘Country Name’ as countryname
• ‘Country Code’ as countrycode

names(immunization)[names(immunization) == "Country_Name"] <- "countryname"
names(immunization)[names(immunization) == "Country_Code"] <- "countrycode"

#7. Rearrange the order of the variables in the following way: year, c, countryname, countrycode, pop,
mort, surv, imm, gdppc, lngdppc

colnames(immunization) <- c("year", "c", "countryname", "countrycode", "mort", "imm", "pop", "gdppc", "surv", "lngdppc") 
immunization <- immunization %>%
  select(year, c, countryname, countrycode, pop, mort, surv, imm, gdppc, lngdppc)

view(immunization_data)
#8. Remove all observation before 1998 and all observations with NA in pop, mort and imm.

immunization <- immunization %>%
  filter(year >= 1998, !is.na(pop), !is.na(mort), !is.na(imm))
view(immunization_data)
#9. Store the number of unique country names in a scalar called “number” and the number of missing values in the gdppc column in “miss_in”. Print number and miss_in.

number <- immunization %>%
  summarize(number = n_distinct(countryname))
miss_in <- sum(is.na(immunization$gdppc))
print(number)
print(miss_in)
#10. Create a dataset where one row is one year, and one column is one country, and the values are the values of the imm variable

immunization_wide <- immunization %>%
  pivot_wider(names_from = countryname, values_from = imm)

view(immunization)
