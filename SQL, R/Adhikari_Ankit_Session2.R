#Session 2


library(tidyverse)

#user read_csv and NOT read.csv
inspection <- read_csv("inspections.csv")

glimpse(inspection)


names <- c("ID", "DBAName", "AKAName", "License", "FacilityType",
           "Risk", "Address", "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results", "Violations", "Latitude", "Longitude",
           "Location"
)

inspection <- read_csv("inspections.csv", col_names = names)

glimpse(inspection)

inspection <- read_csv("inspections.csv", col_names = names,
                       skip = 1)

glimpse(inspection)

#Excercise 2.2 tsv

inpatient <- read_tsv("inpatient.tsv")

glimpse(inpatient)

names <- c("DRG", "ProviderID", "Name", "Address", "City", "State", "ZIP",
           "Region", "Discharges", "AverageCharges", "AverageTotalPayments", "AverageMedicarePayments"
)

inpatient <- read_tsv("inpatient.tsv", col_names = names,
                       skip = 1)

glimpse(inpatient)

types = 'ccccccccinnn'

inpatient <- read_tsv("inpatient.tsv", col_names = names,
                      skip = 1,
                      col_types = types)

glimpse(inpatient)

#Excercise 2.3

stoppages <- read_delim("workstoppages.txt", delim='^')

glimpse(stoppages)

#Excercise 2.4

lengths <- c(32, 50, 24, NA)
names <- c("Name", "Title", "Department", "Salary")
widths <- fwf_widths(lengths, names)

employees <- read_fwf("chicagoemployees.txt", widths, skip = 1)

glimpse(employees)

#Excercise 2.5

library(readxl)
breakfast <- read_excel("breakfast.xlsx")
breakfast <- read_excel("breakfast.xlsx", skip = 3)
glimpse(breakfast)

names <- c("Year", "Freestudents", "Reducedstudents", "Paidstudents", 
           "Totalstudents", "MealsServed", "PercentFree")

breakfast <- read_excel("breakfast.xlsx", skip = 5,
                        col_names = names)

glimpse(breakfast)

breakfast <- breakfast %>%
  mutate(Freestudents=Freestudents*1000000,
         Reducedstudents=Reducedstudents*1000000,
         Paidstudents=Reducedstudents*1000000,
         Totalstudents=Totalstudents*1000000,
         MealsServed=MealsServed*100000,
         PercentFree=PercentFree/100)

glimpse(breakfast)

#Excercise 2.6

library(haven)
spss_table <- read_spss("database test.sav")
spss_table
glimpse(spss_table)
spss_table1 <-as.data.frame(spss_table)
spss_table
glimpse(spss_table)