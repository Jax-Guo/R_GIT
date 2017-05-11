as.Date("1991.11.11",format="%Y.%m.%d")
t <- Sys.time()
unclass(t)
p <- as.POSIXlt(t)
p$sec
p$year
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring,format = "%B %d, %Y %h:%M")
class(x)
strptime()
datestring <- "12-9-2011 09:10"
x <- strptime(datestring, "%B-%d-%Y %H:%M")
x
