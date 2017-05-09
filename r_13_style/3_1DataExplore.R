#position method
xiris <- iris$Sepal.Length
mean(xiris,trim = 0.2,na.rm = T)

set.seed(2017)
w <- rnorm(length(xiris))
weighted.mean(xiris,w)

median(xiris)
quantile(xiris,probs = seq(0,1,0.1))

#prop.table
prop.table(table(iris$Species))

#sample
se <- c(1:10)
sa <- sample(se,10,replace = T,prob = abs(rnorm(10)))

library(caret)
splitindex2 <- createDataPartition(iris$Species,times=10,p=0.1,list=TRUE)
splitindex2

createFolds(iris[,5], k = 2, list = TRUE, returnTrain = FALSE) #每重样本量为75。
createMultiFolds(iris[,5], k = 2, times = 2) #随机生成2组样本，每周又有2重样本，且样本量为75。


createResample(xiris,times = 10,list = T)
