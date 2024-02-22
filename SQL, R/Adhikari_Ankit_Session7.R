#Session 7



#Exercise 7.1
#a) Load the lubridate library, and check the current date and time.
library(tidyverse)
library(lubridate)
today()
now()

#b) Try to read the date today from different formats.

Sys.time()
mdy("01/15/2024")
mdy("01-15/2024")

dmy("15,1,2024")
dmy("15, Jan, 2024")
    
#c) And the time, too.

ymd_hms("24-01-15 10:26:37")
ymd_hm("24-01-15 10:26")

ymd_hms("24-01-15 10:26:37", tz='EST')



#d) What day of the week and of the year is today?

wday("2024-01-15")

wday("2024-01-15", label = TRUE)

wday(today())
yday("2024-01-15")
yday("2024-06-30")



#e) Pablo Picasso was born on October 25, 1881, 11:15 PM. What day of the week?

picasso <- mdy_hm("October 25, 1881, 11:15 PM")
wday(picasso)

wday(picasso, label = TRUE)
wday(picasso, label = TRUE, abbr=FALSE)

#f) What was the year when he was 3 years old?

year(picasso)
year(picasso)+3
#g) Was it a leap year when he was born?

leap_year(picasso)

am(picasso)

semester(picasso)
  #Exercise 7.2
#a) What is the beginning of the current month? Year?

round(0.5)
round(1.5)
  floor_date(now(), unit= "month")
  
  floor_date(now(), unit= "year")
  
  #b) Round the current time to hour.
  round_date(now(), unit = "hour")
  
ceiling_date(now(), unit = "minute")


#c) When this minute will be over?
  
ceiling_date(ymd("2025-12-25"), unit="month")


  #Exercise 7.3
#a) Read the mexicanweather.csv dataset.

weather <- read_csv("mexicanweather.csv")
weather

#b) Separate the year, the month, and the day.

weather <- weather %>% mutate(year=year(date), month=month(date), day=day(date))
weather
#Exercise 7.4
#a) What is the duration of 370 days?

ddays(370)

  #b) A lunar orbit is 29 days, 12 hours and 44 minutes. Add it to 28 January, 2012, and 28 February, 2012.

lunarorbit <- ddays(29) + dhours(12) + dminutes(44)
lunarorbit
dmy("28 January, 2012") + lunarorbit
dmy("28 February, 2012") + lunarorbit


#Exercise 7.5
#a) Add one year period to: 28 February 2020, and to 29 February 2020.

dmy("28 February 2020") + years(1)
dmy("29 February 2020") + years(1)

#b) Add one year duration to 29 February 2020.

dmy("29 February 2020") + dyears(1)
#c) Add one year period to 31 January 2020.

dmy("31 January 2020") + months(1)
##Exercise 7.6
#a) Store JR Tolkien’s birthday: 3 January 1892 9:00 pm and create an interval from that time until now.

tolkien <- dmy_hm("3 January 1892 9:00 pm")

tolkien

tolkien_int <- interval(tolkien, now())
tolkien_int
#b) How old would be JR Tolkien, calculate it with duration and period, too.

#with_period
tolkien_int/years(1)
#duration
tolkien_int/dyears(1)
#Exercise 7.7
#a) Sputnik launch time is 1957/10/4 10:29 pm.

sputnik <- ymd_hm("1957/10/4 10:29 pm")
tz(sputnik)
#b) Using OlsonNames, set it to Moscow time.

OlsonNames()

grep("Moscow", OlsonNames(), value=TRUE)
tz(sputnik)  <- "Europe/Moscow"
sputnik
#c) What was the time in Los Angeles?

with_tz(sputnik, "America/Los_Angeles")
force_tz(sputnik, "America/Los_Angeles")
