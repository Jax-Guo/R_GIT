#cross table
data("UCBAdmissions")
DF <- as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq~Gender+Admit,data = DF)
xt

#flat cross table
warpbreaks$replicate <- rep(1:9,len=54)
xt = xtabs(breaks~.,data=warpbreaks)
xt
ftable(xt)

#data size
object.size(iris)
print(object.size(iris),units = "KB")

#create categorical data
iris$sl <- cut(iris$Sepal.Length,breaks = quantile(iris$Sepal.Length))
table(iris$sl)

library(Hmisc)
library(dplyr)
iris<- mutate(iris,sl=cut2(iris$Sepal.Length,g=4))
table(iris$sl)
