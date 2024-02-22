#Session9-10Project

#Installed all necessary libraries
library(tidyverse)
library(readxl)
library(lubridate)
library(dplyr)
library(stringr)

#Importing the excel file and thn to view it
toronto_project <- read_excel("toronto project.xlsx")
toronto_project
view(toronto_project)


#Selecting the Data Scheet in the excel file to display the data
toronto_project_readable <-read_excel("toronto project.xlsx", sheet = "data")
names<-c("ClinicName","ClinicLocation","Neighborhood","Address","ContactNumber","OperationalHoursByDropIn","OperationalHoursByappointment","Operational Hours","Services")

toronto_project_readable <-read_excel("toronto project.xlsx", sheet = "data", col_names = names, skip= 4)
glimpse(toronto_project_readable)

#Renaming Columns
toronto_project_readable <- toronto_project_readable %>%   
  rename("OperationalHoursByDropIn" = "Operational Hours") %>%   
  rename("OperationalHoursByappointment"= "...7" )

view(toronto_project_readable)

#Mutating both `OperationalHoursByDropIn` and `OperationalHoursByappointment`
toronto_project_readable <- toronto_project_readable %>% mutate(`OperationalHoursByDropIn` = replace(`OperationalHoursByDropIn`, 1, NA))
toronto_project_readable <- toronto_project_readable %>% mutate(`OperationalHoursByAppointment` = replace(`OperationalHoursByappointment`, 1, NA))

#Putting NA's where there is no information given
toronto_project_readable [10, "Clinic Name"] <- "Black Creek Community Health Centre (Sheridan Mall Site)"
toronto_project_readable [11, "Clinic Name"] <- NA

toronto_project_readable [18, "Clinic Name"] <- "Black Creek Community Health Centre (Yorkgate mall Site)"
toronto_project_readable [19, "Clinic Name"] <- NA

toronto_project_readable [10, "Address"] <- "North York Sheridan Mall, Unit 5 2202 Jane St., Toronto, On M2M 1A4"
toronto_project_readable [11, "Address"] <- NA

toronto_project_readable [35, "Address"] <- "Flemingdon Health Center 10 Gateway Blvd., Toronto, On M3C 3A1"
toronto_project_readable [36, "Address"] <- NA


toronto_project_readable [87, "Address"] <- "Scarborough Civic Center 160 Borough Dr., Toronto, On M1P 4N8"
toronto_project_readable [88, "Address"] <- NA
         

view(toronto_project_readable)

#Separating `OperationalHoursByDropIn` and `OperationalHoursByappointment`

toronto_project_readable <- toronto_project_readable %>%
separate(col = OperationalHoursByDropIn, into = c("Day", "Time"), sep = ".")
toronto_project_readable <- toronto_project_readable %>%
  separate(col = OperationalHoursByappointment, into = c("Day", "Time"), sep = ".")

#Using Distinct to segrate the available Data
toronto_project_readable <- toronto_project_readable %>%
  distinct()
toronto_project_readable

#Now uniting into Appointment table
toronto_project_readable <- toronto_project_readable %>%
  unite(Appointment, Day, Time, sep = " ")

#Widing the services column
toronto_project_readable <- toronto_project_readable %>%
  pivot_wider(
    names_from = Services,
    values_from = Services,
    values_fn = list
  )
  
glimpse(toronto_project_readable)


#Mutating the data inside services column

toronto_project_readable <- toronto_project_readable %>%
  mutate(across(c(`Birth control counselling`, `Low cost or free birth control`, `Free condoms`, `Plan B (emergency contraceptive pill)`,  `STI testing and free treatment`, `HIV testing`, `Pregnancy testing, counselling and referral`,
      `Anonymous HIV testing (including the rapid HIV test)`,`Sexuality and relationship counselling`, `Rapid HIV testing`,`Anonymous HIV testing (including the rapid HIV test) - By Appointment Only`), 
    ~ ifelse(is.na(.) | . == "NA" | . == "", FALSE, TRUE)
  ))
view(toronto_project_readable)

