library(lubridate)
Sys.getlocale("LC_TIME")
Sys.setlocale(locale = "en_US")
today()
now()
ymd("1989 May 17")
ymd("1989 5 17")
mdy("3-12-1975",tz = "America/New_York")
dt1 <- "2014-08-23 17:23:02"
ymd_hms(dt1)
dt2 <- c("2014-05-14","2014-09-22","2014-07-11")
ymd(dt2)
update(this_moment, hours = 8, minutes = 34, seconds = 55)
this_moment
this_moment <- update(this_moment, hours = 8, minutes = 34, seconds = 55)
#time zone list: http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
nyc <- now(tzone = "America/New_York")
depart <- nyc + days(2)
depart <- update(depart,hours=17,minutes=34)
arrive <- depart + hours(15) + minutes(50)
arrive <- with_tz(arrive,tzone = "Asia/Hong_Kong")

#将+号放在最后一行，不然会报错
depart %>%
    update(hours=17,minutes=34) %>%
    with_tz(tzone = "Asia/Hong_Kong") %>%
    + hours(15) + minutes(50) %>%
    print

last_time <- ymd("2008-June-17")
last_time <- mdy("March 12, 2008")
how_long <- interval(last_time,arrive)
as.period(how_long)

?Sys.timezone
julian(now())
