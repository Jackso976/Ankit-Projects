#Session 8


#Exercise 8.1
#a) Load inspections dataset (you can also load it from your computer):
library(tidyverse)
library(stringr)
names <- c("ID", "DBAName", "AKAName", "License", "FacilityType", "Risk", "Address",
           "City", "State", "ZIP", "InspectionDate", "InspectionType", "Results",
           "Violations", "Latitude","Longitude","Location")
inspections <- read_csv('inspections.csv',
                        col_names=names, skip=1)
inspections
regional_inspections <- unite(inspections,Region,City,State,sep=", ", remove=FALSE)
unique(regional_inspections$Region)

#b) Set all region names to UPPERCASE

regional_inspections <- regional_inspections %>%
  mutate(Region=str_to_upper(Region))
unique(regional_inspections$Region)

#c) Let's take care of a few misspellings of Chicago. Change them to CHICAGO, IL

badchicagos <- c("CCHICAGO,IL","CCHICAGO,IL","CHICAGOCHICAGO,IL","CHCHICAGO,IL","CHICAGOI,IL")

#d) Correct the case where we don’t know the state of Chicago.
regional_inspections <- regional_inspections %>%
  mutate(Region=ifelse(Region %in% badchicagos,"CHICAGO, IL",Region))

unique(regional_inspections$Region)

regional_inspections <- regional_inspections %>%
  mutate(Region=ifelse(Region == "CHICAGO, NA","CHICAGO, IL",Region))

unique(regional_inspections$Region)
#e) Unify NAs and missing data to NA.

naregions <- c("NA, NA", "NA, IL", "INACTIVE, IL")

regional_inspections <- regional_inspections %>%
  mutate(Region=ifelse(Region %in% naregions,NA,Region))
unique(regional_inspections$Region)

#Exercise 8.2
#a) Load the inpatient.tsv data.
names <- c("DRG", "ProviderID", "Name", "Address", "City", "State", "ZIP", "Region", "Discharges",
"AverageCharges", "AverageTotalPayments",
 "AverageMedicarePayments")
types = 'ccccccccinnn'
inpatient <- read_tsv('inpatient.tsv', col_names = names, skip=1,
col_types = types)
inpatient_separate <- separate(inpatient,DRG,c('DRGcode','DRGdescription'),4)

glimpse(inpatient_separate)

#b) Trim the DRGcode field.

inpatient_separate <- inpatient_separate %>% mutate(DRGcode=str_trim(DRGcode))

glimpse(inpatient_separate)

#c) Remove the ‘ – ‘ from the beginning of the DRGdescription column.

inpatient_separate <- inpatient_separate %>% mutate(DRGdescription=str_sub(DRGdescription, 3))

glimpse(inpatient_separate)


#Exercise 8.3
#a) Use this code to read the inspections dataset.
names <- c('InspectionID', 'RestaurantName', 'OtherName', 'LicenseNumber', 'FacilityType', 'Risk',
           'Address', 'City', 'State', 'ZIP', 'InspectionDate', 'InspectionType', 'Results',
           'Violations', 'Latitude', 'Longitude', 'Location')
inspections <- read_csv("inspections.csv", col_names=names, skip=1)
glimpse(inspections)
#b) Check most inspected restaurants.

inspections %>% group_by(RestaurantName) %>% summarise(inspections =n()) %>%
  arrange(desc(inspections))


#c) Add a column to the dataframe when the RestaurantName includes “MCDO” using str_detect(). How many of the found?

inspections <- inspections %>% mutate(Mcdo = str_detect(RestaurantName, pattern = "MCDO"))
sum(inspections$Mcdo)
sum(str_detect(inspections$RestaurantName, pattern = "MCDO"))



#d) Create a vector wrongMcDo with the wrong names.

wrongmcdo <- unique(str_subset(inspections$RestaurantName, pattern = "MCDO"))
wrongmcdo
#e) Find alternate spellings of McDonalds using grepl()
inspections %>% filter(grepl("MCDO",RestaurantName , ignore.case =TRUE)) %>%
  select(RestaurantName) %>% unique() %>% 
  view()

#f) Create a vector of those alternate spellings.

inspections %>% filter(grepl("MCDO",RestaurantName , ignore.case =TRUE)) %>%
  filter(RestaurantName != "SARAH MCDONALD STEEL") %>%
  select(RestaurantName) %>% 
  unique() %>% 
  view()

#g) Replace them all with MCDONALDS.

inspections %>% filter(grepl("MCDO", DBAName, ignore.case=TRUE)) %>% filter(DBAName != 'SARAH MCDONALD STEELE') %>%
  select(DBAName) %>%
  unique()
#h) Check most inspected restaurants again.

wrongmcdo2 <- inspections %>% filter(grepl("MCDO",RestaurantName , ignore.case =TRUE)) %>%
  filter(RestaurantName != "SARAH MCDONALD STEEL") %>%
  select(RestaurantName) %>% unique()

inspections <- inspections %>% mutate(RestaurantName = ifelse(RestaurantName %in% wrongmcdo2$RestaurantName,'MCDONALDS',RestaurantName))

inspections %>% group_by(RestaurantName) %>% summarise(inspections =n()) %>%
  arrange(desc(inspections))


#Exercise 8.bonus:
#a) Import the ForeignAid.tsv dataset. Pay attention to headings.

ForeignAid <- read_tsv("ForeignAid.tsv")

ForeignAid
#b) Clean the country column, in reality, we have to countries, South Korea and North Korea.

ForeignAid <- ForeignAid %>%
  mutate(Country = case_when(
    str_detect(Country, "N") ~ "North Korea",
    str_detect(Country, "S") ~ "South Korea",
    TRUE ~ Country
  ))

ForeignAid


#c) Clean the FundingAgency column. Try to find how many agencies are, and create a constant called “agency” that is the number of unique agencies.

ForeignAid <- ForeignAid %>%
  mutate(FundingAgency = tolower(FundingAgency))

ForeignAid <- ForeignAid %>%
  mutate(FundingAgency = case_when(
    str_detect(FundingAgency, "dept") ~ "Department",
    str_detect(FundingAgency, "agency") ~ "Agency",
    str_detect(FundingAgency, "development") ~ "Development",
    str_detect(FundingAgency, "trade") ~ "Trade",
    str_detect(FundingAgency, "state") ~ "State",
    TRUE ~ FundingAgency
  ))

agency_count <- ForeignAid %>%
  distinct(FundingAgency) %>%
  nrow()
ForeignAid

agency_count


#d) Transform the FundingAmount variable to numeric without creating NAs (you may need several manipulations: removing monetary symbols, commas, negative signs, etc. before changing the type).


str(ForeignAid)

ForeignAid <- ForeignAid %>%
  mutate(FundingAmount = gsub("\\$", "", FundingAmount),
         FundingAmount = gsub(",", "", FundingAmount),  
         FundingAmount = as.numeric(FundingAmount))     

ForeignAid

ForeignAid <- na.omit(ForeignAid)
#e) Create a frequency table for an adequate variable.

country_frequency <- ForeignAid %>%
  group_by(Country) %>%
  summarise(Frequency = n())

country_frequency
