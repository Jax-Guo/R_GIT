# 应用案例—K-均值聚类
# 在本例中，我们使用iris数据集演示k-means聚类的过程。
iris2<-iris
# 移除Species属性
iris2$Species<-NULL # 等价于 iris2 <- iris2[,1:4]
# 利用kmeans()函数进行k-means聚类，并将聚类结果储存在变量kmeans.result中。
(kmeans.result<-kmeans(iris2,3))
# 查看划分效果
table(iris$Species,kmeans.result$cluster)
# 然后，绘制所有的簇和簇中心。
plot(iris2[c("Sepal.Length","Sepal.Width")],
     col=kmeans.result$cluster)
# plot cluster centers
points(kmeans.result$centers[,c("Sepal.Length","Sepal.Width")],
       col=1:3,pch=8,cex=2)

#应用案例:利用Vehicle数据集进行K均值聚类
# 导入数据源
vehicle <- read.csv("Vehicle.csv")
vehicle1 <- vehicle
# 移除NUMBER.OF.CLASSES变量
#vehicle1$NUMBER.OF.CLASSES <- NULL
vehicle1 <- vehicle1[,1:18]
# 利用kmeans()函数进行k-means聚类，并将聚类结果储存在变量kmeans.result中。
(kmeans.result<-kmeans(vehicle1,4))
# 查看分类效果
table(vehicle$NUMBER.OF.CLASSES,kmeans.result$cluster)
# 对聚类结果进行可视化
plot(vehicle1[,1:2],col=kmeans.result$cluster)
points(kmeans.result$centers[,1:2],col=1:4,pch=8,cex=2)

# 应用案例—层次聚类
w<-read.csv("LA.Neighborhoods.csv")
w<-data.frame(w,density=w$Population/w$Area)
# 选择变量
u<-w[,c(1,2,5,6,11,16)]
# 标准化数据，聚类方法="complete"
hh<-hclust(dist(scale(u[,-1])),"complete")
# 画树状图
plot(hh,labels=w[,1],cex=0.6)
# 自动分成5类
rect.hclust(hh,k=5)
# 画出数据分层聚类所得5类街区按照经纬度在洛杉矶的点图
id<-cutree(hh,k=5)
ppp=c(7,17,19,21,24)
plot(w[id==1,14:15],pch=ppp[1],col=1,xlim=c(-118.7,-118.1),
     ylim=c(33.73,34.32),main="Los Angeles")
for(i in 2:5) points(w[id==i,14:15],pch=ppp[i])
legend("bottomleft",pch=ppp,paste("Cluster",1:5))

#应用案例 mtcars数据集-层次聚类
# 选择变量
mtcars1 <- mtcars[,c('mpg','disp','hp','drat','wt','qsec')]
# 标准化数据，聚类方法="complete"
h <- hclust(dist(scale(mtcars1)),'complete')
# 画树状图
plot(h,labels=rownames(mtcars1),cex=0.6)
# 自动分成4类
rect.hclust(h,k=4)
w <- t(mtcars)
h1 <- hclust(dist(w))
plot(h1)
