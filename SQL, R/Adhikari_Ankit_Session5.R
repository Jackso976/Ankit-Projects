#Session 5

#Exercise 5.1
#a) Import the inspections.csv dataset. (Hint: reuse your code from Day1)

library(tidyverse)
inspection <- read_csv("inspections.csv")
names <- c("ID", "DBAName", "AKAName", "License", "FacilityType",
           "Risk", "Address", "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results", "Violations", "Latitude", "Longitude",
           "Location"
)

inspection <- read_csv("inspections.csv", col_names = names)

glimpse(inspection)

inspection <- read_csv("inspections.csv", col_names = names,
                       skip = 1)

glimpse(inspection)
#b) Look at a summary of the data.

summary(inspection)

#c) Create two tibbles, one including restaurants with license, and one without license
unlicensed <- inspection %>% filter(is.na(License))
licensed <- inspection %>% filter(!is.na(License))


#Exercise 5.2
#a) Run this: badmath <- c(1,2,3,4/0,0/0,NA)

badmath <- c(1,2,3,4/0,0/0,NA)
badmath
#b) Check which values are NA, NaN, and infinite.

is.na(badmath)
is.nan(badmath)

is.infinite(badmath)
is.finite(badmath)

#Exercise 5.3
#a) Load the heating.csv dataset and check its content.

heating <- read_csv("heating.csv")

glimpse(heating)
#b) Tidy the data (use ‘age’ and ‘homes’ for the new variables, and don’t lose special characters (like ‘.’ or ‘Z’). Try to mutate ‘homes’ to numeric.You got the information that “ ‘Z’ means 0 and ‘.’ stands the for the cases where there is no observation.”

heating <- heating %>% pivot_longer(!Source, names_to = "age", values_to = "homes", values_transform = list(homes = as.character))

glimpse(heating)
#c) Using this information, solve the problem of seemingly missing values.

heating %>% mutate(homes=as.numeric(homes))

glimpse(heating)

heating %>% filter(is.na(as.numeric(homes)))

heating <- heating %>% mutate(homes = ifelse(homes=='.', 0, homes)) %>% mutate(homes = ifelse(homes=='z', 0, homes)) %>% mutate(homes = as.numeric(homes))
  
glimpse(heating)       
#Exercise 5.4

#a) Load publiclands.csv. It is about the public land area in each state of the US.

land <- read.csv("publiclands.csv")
nrow(land)
unique(land$State)

#b) Look at the summary of the data
summary(land)
#c) Check the number of rows and display the unique states.

nrow(land)
unique(land$State)
#d) Create a new tibble called missing_states with the data for the following 8 states: 'Connecticut','Delaware', 'Hawaii', 'Iowa', 'Maryland', 'Massachusetts', 'New Jersey', 'Rhode Island'

missing_states <- tibble(State=c('Connecticut','Delaware', 'Hawaii', 'Iowa', 'Maryland', 'Massachusetts', 'New Jersey', 'Rhode Island'), PublicLandAcres = c(0,0,0,0,0,0,0,0))


#e) Bind the rows to the original dataset.

land_full <- rbind(land, missing_states)


#f) Calculate the average public land area in the original and in the extended dataset.

mean(land$PublicLandAcres)
mean(land_full$PublicLandAcres)

#Exercise 5.5

#a) Load the employees.csv data.

employees <- read.csv("employees.csv")


#b) Compute the sum, the mean, and the maximum of salaries

sum(employees$Salary)
mean(employees$Salary)
max(employees$Salary)



#c) Repeat b) with removing NAs.
sum(employees$Salary, na.rm=TRUE)
mean(employees$Salary, na.rm=TRUE)
max(employees$Salary, na.rm=TRUE)

#Exercise 5.6
#a) Load the continents.csv data

continents <- read_csv("continents.csv")
continents <- unique(continents)

#b) Repair the dataset by removing duplicates.

continents <- continents %>% filter(!(Continent=="Antarctica" & Population > 10000))
view(continents)


#Exercise 5.7
#a) Load population.csv. This file is about the population of Carpentria city by demographic categories

population <- read_csv("population.csv")

glimpse(population)

#b) Calculate the total population using sum().

sum(population$Population)




#c) Remove the not necessary rows and recalculate the total population.
population <- population %>% filter(!(Subject %in% c('Total', 'Male', 'Female')))

#d) Check if your result seems to be correct (Hint: Wikipedia can be your friend).

sum(population$Population)
#Exercise 5.8
#a) Load and make tidy the mexicanweather.csv dataset. (Hint: you can reuse your code from Day2)
weather <- read.csv("mexicanweather.csv")
weather.wide <- pivot_wider(weather, names_from = element, values_from = value)
weather.wide
#b) Check the tail of the dataset. We really don't need all of those lines that have two NA values.

tail(weather.wide)
weather.wide <- weather.wide %>% filter(!(is.na(TMAX) & is.na(TMIN)))
tail(weather.wide)
#c) Rename the temperatures as mintemp and maxtemp, put mintemp before maxtemp.
weather.wide <- weather.wide %>% rename(maxtemp=TMAX, mintemp=TMIN) %>% select(station, date, mintemp, maxtemp)


#d) What unit can it be? Celsius? Fahrenheit?

weather.wide <- weather.wide %>% rename(maxtemp=TMAX, mintemp=TMIN) %>% select(station, date, mintemp, maxtemp)
  
  
#e) Divide the values by 10.

weather.wide <- weather.wide %>% mutate(mintemp = mintemp/10) %>% mutate(maxtemp = maxtemp/10)
weather.wide
#f) Suppose that the values created in e) are in Celsius, create weather_fahrenheit with the values in Farenheit

weather_Fahrenheit <- weather.wide %>% mutate(mintemp = mintemp*(9/5)+32) %>% mutate(maxtemp = maxtemp*(9/5)+32)
weather_Fahrenheit
