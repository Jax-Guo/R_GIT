#查看缺失值信息
install.packages("mice")
install.packages("VIM")
library(mice)
library(VIM)
data(sleep,package = "VIM")
md.pattern(sleep)
aggr(sleep,prop=F,numbers=T)

#缺失值差补
install.packages("missForest")
library(missForest)
z <- missForest(airquality,verbose = T)
airquality_full <- z$ximp

#异常值监测
install.packages("qcc")
library(qcc)
data(orangejuice)
attach(orangejuice)
qcc(D[trial], sizes=size[trial], type="p")

x <-c(1:100,200)
(b1 <- boxplot.stats(x))

iris1 <- iris[,1:4]
kmeans.result <- kmeans(iris1,3)
kmeans.result
centers <- kmeans.result$centers[kmeans.result$cluster,]
distances <- sqrt(rowSums((iris1 - centers)^2))
outliers <- order(distances,decreasing = T)[1:5]
print(iris1[outliers,])
plot(iris1[,c("Sepal.Length","Sepal.Width")],pch="o",
     col=kmeans.result$cluster,cex=0.3)
# 画出类中心
points(kmeans.result$centers[,c("Sepal.Length","Sepal.Width")],col=1:3,
       pch=8,cex=1.5)
# 画出离群点
points(iris1[outliers,c("Sepal.Length","Sepal.Width")],pch="+",col=4,cex=1.5)
