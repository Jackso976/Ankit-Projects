#Exercise 3.1

library(tidyverse)
#a) Read in the Pew dataset: http://594442.youcanlearnit.net/pew.csv

pew <- read_csv("pew.csv")
pew
#b) Take a look at it. Is it a tidy dataset? Why?

glimpse(pew)
#c) Make it tidy. Hint: here, longer seems to be better
pew.long <- pivot_longer(pew, !religion, names_to='income', values_to = 'freq')
pew.long

#Exercise 3.2
#a) Read in the Mexican weather dataset: http://594442.youcanlearnit.net//mexicanweather.csv

weather <- read.csv("mexicanweather.csv")

#b) Take a look at it. Is it a tidy dataset? Why?
weather

#c) Make it tidy. Hint: here, wider seems to be better
weather.wide <- pivot_wider(weather, names_from = element, values_from = value)
weather.wide


#Exercise 3.3
#a) Read the Bond.txt file to bond_df (Hint: first, find out what type of file you may have here)

bond <- read_tsv("Bond.txt")
bond
#b) Pivot all columns except Bond to a longer format and set the names of the newly created columns to decade and n_movies.
bond %>% pivot_longer(!Bond, names_to = "Decade", values_to = "n_movies")
bond.long <- bond %>% pivot_longer(!Bond, names_to = "Decade", values_to = "n_movies")

#c) Drop any NA values in the n_movies column while it is created.
bond %>% pivot_longer(!Bond, names_to = "Decade", values_to = "n_movies", values_drop_na = TRUE)

#d) Transform the decade column data type to integer.

bond %>% pivot_longer(!Bond, names_to = "Decade", values_to = "n_movies", 
                      values_drop_na = TRUE, names_transform = list( decade = as.integer))


#Exercise 3.4

#a) Read the data about planets from planets.xlsx and load into a tibble called planet_df
library(readxl)
planet_df <- read_excel("planets.xlsx")
planet_df
planet_df <- read_excel("planets.xlsx", sheet = 2)
planet_df

#b) Transpose the dataset, so to have the planets in the first column and each metric in a different column. (Hint: you need two steps, once make it wider, and once make it longer).


planet_df %>% pivot_longer(!metric, names_to = "planet") %>% pivot_wider(names_from = metric, values_from = value)

planet_df <- planet_df %>% pivot_longer(!metric, names_to = "planet") %>% pivot_wider(names_from = metric, values_from = value)
planet_df


#c) Are the data types are as expected? If not, change them, use double for numbers that are not surely integers, integer for naturally integer numbers)

glimpse(planet_df)
planet_df <- planet_df %>% mutate(mass = as.numeric(mass), diameter = as.double(diameter), gravity = as.double(gravity), 
                                  length_of_day = as.double(length_of_day), distance_from_sun = as.double(distance_from_sun), 
                                  mean_temperature = as.double(mean_temperature),
                                  surface_pressure = as.double(surface_pressure),
                                  number_of_moons = as.integer(number_of_moons)
                                  )

planet_df
glimpse(planet_df)


#Bonus Excercise
library(readxl)
s3 <- read_csv("S3_2.csv")
s3

s3.long <- pivot_longer(s3, !athlete, names_to = 'level', values_to = 'data')
s3.long

s31 <- read_csv("S3.csv")

s31

s31.long <- s31 %>% pivot_longer(s31, !type, names_to = 'level', values_to = 'data')
