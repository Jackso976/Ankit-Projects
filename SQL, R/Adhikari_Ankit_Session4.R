#Session 4

#Exercise 4.1
#a) Load the tidyverse and read in the Medicare payments dataset (inpatient) (Hint: you can reuse your code from Session 2)

library(tidyverse)
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

#b) Take a look at the diagnosis-related group (DRG) unique values.
unique(inpatient$DRG)

unlicensed <- inspection %>% filter(is.na(License))

#c) Let's try separating this on the hyphen, use DRGcode and DRGdescription as the new variable names.

inpatient_separate <- separate(inpatient, DRG, c("DRGcode", "DRGdescription"), '-')

#d) Take a look at the error message and try to find out what is going on.
inpatient$DRG[45894]

#e) Let's separate with character position instead.

inpatient_separate <- separate(inpatient, DRG, c("DRGcode", "DRGdescription"), 3)


#f) Take a look at the data now (use glimpse).
glimpse(inpatient_separate)

#Exercise 4.2
#a) Load the tidyverse and the food inspections dataset (inspections)

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


#b) Create a new column called Regions that combines City and State. Save the new data as regional_inspections.

regional_inspections <- unite(inspection, Regions, City, State, sep=', ')
#c) Look at the data.
glimpse(regional_inspections)

#d) What to do if you don’t want to delete City and State? Don’t remove them! (Hint: check the remove argument.)
regional_inspections <- unite(inspection, Regions, City, State, sep=', ', remove= FALSE)

#e) Take a look at the unique regions. Do you feel the efforts useful?
unique(regional_inspections$Regions)

  #Exercise 4.3 (alone)
#a) Import the data-messy.xlsx file as rainfall. Pay attention to the right header.

library(readxl)
rainfall <- read_excel("messy-data.xlsx", skip=2)

view(rainfall)
#b) Separate the month and the period into two columns.

table_name <- c("Time", "LakeVictoria", "Simiyu")

rainfall <- read_excel("messy-data.xlsx", col_names= table_name, skip=3)
rainfall_separate <- separate(rainfall, Time, c("Month", "Period"), ",")
glimpse(rainfall_separate)
view(rainfall_separate)
#c) Remove mm from the data where it is necessary and change the data type (to prepare for later analysis).

rainfall_separate$LakeVictoria <- as.numeric(gsub("mm", "", rainfall_separate$LakeVictoria))
rainfall_separate$Simiyu <- as.numeric(gsub("mm", "", rainfall_separate$Simiyu))
view(rainfall_separate)

#d) Restructure data, the geographical location should be a variable (call it “Place”). The new numeric variable should be called “rainfall”.


rainfall_locationunite <-pivot_longer(rainfall_separate, cols = c(LakeVictoria, Simiyu), names_to = "Place", values_to = "Rainfall") 

view(rainfall_locationunite)

#e) Take a look at the database now. Propose an additional change (and explain shortly why) and execute it

#FinalName
#We can change the name of the final table
rainfall_Data <- rainfall_locationunite
view(rainfall_Data)
