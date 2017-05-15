#Get/set working directory
setwd("./data")
getwd("./data")

#checking for and creating directories
file.exists()
file.create()
dir.exists()
dir.create()

#read xlsx
library(xlsx)
data <- read.xlsx("./data",sheetIndex = 1,header = T)

install.packages("XLConnect")
library(XLConnect)

#Json
install.packages("jsonlite")
library(jsonlite)
iris.json <- toJSON(iris,pretty = T)
cat(iris.json)
iris <- fromJSON(iris.json)

#data.table
library(data.table)
DT <- data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT)
tables()
DT[DT$y=='a',]
DT[,DT$y=='a']
DT[,DT$y=='a']
DT[,list(mean(x),sum(z))]
DT[,table(y)]
DT[,w:=z^2]
DT2 <- copy(DT)
DT[,a:=x>0]
DT[,b:=mean(x+w),by=a]
DT[,.N,by=y]
setkey(DT,y)
DT['a']
DT$a

require(data.table)
names(ChickWeight) <- tolower(names(ChickWeight))
DT <- melt(as.data.table(ChickWeight), id=2:4)
DT <- DT[,id:=1:nrow(DT)]
dcast(DT, id+time+chick+diet~ variable)
#与下面例子的区别是下面的例子中id是各行都不相同的，而DT中diet与weight则是多对多
dcast(DT, diet ~ variable, fun=mean)

x<-data.table(id=1:6,
              name=c("wang","zhang","li","chen","zhao","song"),
              shuxue=c(89,85,68,79,96,53),
              yuwen=c(77,68,86,87,92,63))
x1 <- melt(x,id=c("id","name"),variable.name = "test")
x2 <- dcast(x1,id+name~test)        
x3 <- dcast(x1,test~id+name)
