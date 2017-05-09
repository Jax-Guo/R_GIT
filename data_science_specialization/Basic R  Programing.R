#create a empty vector
vector() 

#specific numeric
class(NaN)
Inf
NaN

#attributes
a <- matrix(1:4,nrow = 2)
attributes(a)

#ordered factor
x <- factor(c("yes", "yes", "no", "yes", "no"),ordered = T,levels = c("yes", "no"))
unclass(x)

#frame to matrix
mt <- data.matrix(mtcars)

#names()
a <- c(1:9)
names(a) <- paste0("a",1:9)

#make table reading faster
initial <- read.table("datatable.txt", nrows = 100)
classes <- sapply(initial, class)
tabAll <- read.table("datatable.txt",colClasses = classes)

#dput dget
y <- data.frame(a = 1, b = "a")
dput(y)
dput(y,file = "y.R")
dget(file = "y.R")

#dump可以保存多个，而dput只能保存一个
z <- c(1:10)
dump(c("x","y"))
ls()
rm(x,y)
source(file = "dumpdata.R")

#file
dumpf <- file("dumpdata.R","r")
dumpc <- readLines(dumpf)
close(dumpf)

#keep matrix type
m <- matrix(1:6, 2, 3)
m[1,2,drop=F]

#list
x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)]

#partial matching
x <- list(aardvark = 1:5)
x$a
x[["a"]]
x[["a", exact = FALSE]]

#remove missing value
x <- c(1, 2, NA,3, 4, NA, 5)
y <- c("a", "b", NA, "d", NA,3, "f")
good <- complete.cases(x, y)
good
x[good]
y[good]

airquality[1:6, ]
good <- complete.cases(airquality)
airquality[good,][1:6,]
