#Basic Plot
# 颜色
# 对women数据集绘制散点图，并用红色表示散点。
plot(women,col="red") # 通过颜色名称
plot(women,col=554)   # 通过颜色下标
plot(women,col="#FF0000") #通过十六进制的颜色值
Hex<- rgb(red=255,green=0,blue=0,max=255)
plot(women,col=Hex) # 通过RGB值
# 对其他图形参数颜色进行设置
plot(women,main="身高 VS 体重 散点图",sub="数据来源：women数据集",
     col="red",col.main="green",col.sub="blue",
     col.axis="grey",col.lab="yellow")
colors()
# 主题颜色
par(mfrow=c(3,2))
barplot(rep(1,6),col=rainbow(6),main="barplot(rep(1,6),col=rainbow(6))")
barplot(rep(1,6),col=heat.colors(6),main="barplot(rep(1,6),col=heat.colors(6))")
barplot(rep(1,6),col=terrain.colors(6),main="barplot(rep(1,6),col=terrain.colors(6))")
barplot(rep(1,6),col=topo.colors(6),main="barplot(rep(1,6),col=topo.colors(6))")
barplot(rep(1,6),col=cm.colors(6),main="barplot(rep(1,6),col=cm.colors(6))")
par(mfrow=c(1,1))
# RColorBrewer颜色扩展包
# RColorBrewer-seq连续型
library(RColorBrewer)
display.brewer.all(type="seq")
# 如果想使用YlOrRd组的第3~8种颜色，可以使用下面代码实现。
barplot(rep(1,6),col=brewer.pal(9,"YlOrRd")[3:8])
# RColorBrewer-div极端型
display.brewer.all(type="div")
# 如果想使用BrBG组的第3~8种颜色，则可用下面代码来实现。
barplot(rep(1,6),col=brewer.pal(11,"BrBG")[3:8])
# RColorBrewer-qual离散型
display.brewer.all(type="qual")
# 如果想使用Set3组的第3~8种颜色，则可用下面代码来实现。
barplot(rep(1,6),col=brewer.pal(12,"Set3")[3:8])

# 文字
# 字体
plot(0:4,type="n",axes = F,xlab = NA,ylab = NA)
text(2,4,labels="font=1:正常字体（默认）",font=1)
text(2,3,labels="font=2:粗体字体",font=2)
text(2,2,labels="font=3:斜体字体",font=3)
text(2,1,labels="font=4:粗斜体字体",font=4)
# 大小
plot(0:5,type="n",axes = F,xlab = NA,ylab = NA)
text(2,5,labels="cex=0.5:放大0.5倍",cex=0.5)
text(2,1,labels="cex=2:放大2倍",cex=2)

# 点元素
plot(1,col="white",xlim=c(1,7),ylim=c(1,7))
for(i in c(0:25)){
  x<-(i %/% 5)*1+1
  y<-6-(i%%5)
  if(length(which(c(21:25)==i)>=1)){ #21-25的点格式可以设置背景颜色。
    points(x,y,pch=i,bg="red",cex=2)
  } else {
    points(x,y,pch=i,cex=2)
  }
  text(x+0.2,y+0.2,labels=paste("pch=",i))
}

# 线元素
# 线样式
data<-matrix(rep(rep(1:7),10),ncol=10,nrow=7)
plot(data[1,],type="l",lty=0,ylim=c(1,8),xlim=c(-1,10),axes=F)
text(0,1,labels="lty=0")
for(i in c(2:7)){
  lines(data[i,],lty=i-1)
  text(0,i,labels=paste("lty=",i-1))
}
# 线粗细
data<-matrix(rep(rep(1:6),10),ncol=10,nrow=6)
plot(data[1,],type="l",lwd=0.5,ylim=c(1,8),xlim=c(-1,10),axes=F)
text(0,1,labels="lwd=0.5")
lines(data[2,],type="l",lwd=0.8);text(0,2,labels="lwd=0.8")
lines(data[6,],type="l",lwd=4);text(0,6,labels="lwd=4")

# 标题
attach(iris)
boxplot(Sepal.Length~Species,col=heat.colors(3),
        main=list("Sepal.Length按照Species分类的箱线图",
                  font=4,col="red",cex=1.5),
        sub=list("数据来源：iris数据集",font=3,
                 col="green",cex=0.8),
        xlab="Species",ylab="Sepal.Length")
# title函数
boxplot(Sepal.Length~Species,col=heat.colors(3))
title(main=list("Sepal.Length按照Species分类的箱线图",
                font=4,col="red",cex=1.5),
      sub=list("数据来源：iris数据集",font=3,
               col="green",cex=0.8),
      xlab=list("Species",
                col="blue",cex=1.1,font=2),
      ylab="Sepal.Length")

# 坐标轴
#加载iris数据到内存
attach(iris)
#绘制箱线图
boxplot(Sepal.Length~Species,col=heat.colors(3),
        axes=FALSE,xlab="Species",ylab="Sepal.Length")
#设置X轴样式
axis(side=1,at=1:3,labels=unique(Species),col.axis="red",tick=FALSE)
#设置Y轴样式
axis(side=2,col.ticks = "gold",font = 3,col = "blue")

# 图例
#绘制分组柱状图
barplot(VADeaths,beside = TRUE,col=cm.colors(5))
# 添加图例
legend("top",legend=rownames(VADeaths),
       ncol=5,fill=cm.colors(5),bty="n")

# 网格线
op <- par(mfcol=1:2)
barplot(VADeaths,beside = TRUE,col=cm.colors(5),
        main="plot VADeaths with grid()")
grid()
barplot(VADeaths,beside = TRUE,col=cm.colors(5),
        main="plot VADeaths with grid(NA,7,lty=2,lwd=1.5,col='green')")
grid(NA,7,lty=2,lwd=1.5,col="green")
par(op)

# 点
set.seed(1234)
data <- c(rnorm(100,mean=0,sd=1),rnorm(3,mean=4,sd=1))
boxplot(data,col="violet",ylim=c(-4,5),outline=F)
points(rep(1,3),data[101:103],pch=21,bg="yellow",cex=1.2)

# 文字
text(rep(1,3),data[101:103],pos=4,label=paste0("异常值",data[101:103]))

# 线
# abline函数
sol.lm<-lm(iris[,1]~iris[,3])
plot(iris[,1]~iris[,3],col="blue")
abline(sol.lm,col="red")
# lines函数
# draw a smooth line through a scatter plot
plot(cars, main = "Stopping Distance versus Speed")
lines(stats::lowess(cars))

#### base系统
# 散点图
# 普通散点图
par(mfrow=c(1,2))
# 绘制一维数据
plot(x=rnorm(10)) 
# 绘制二维数据
plot(women)
par(mfrow=c(1,1))
# 散点图矩阵
plot(iris[,1:4],main="利用plot函数绘制散点图矩阵")
# 高密度散点图
set.seed(1234)
n<-10000
c1<-matrix(rnorm(n,mean=0,sd=.5),ncol=2)
c2<-matrix(rnorm(n,mean=3,sd=2),ncol=2)
mydata<-rbind(c1,c2)
mydata<-as.data.frame(mydata)
names(mydata)<-c("x","y")
par(mfrow=c(1,2))
with(mydata,plot(x,y,pch=19,main="Basic Plot with 10,000 Obsevations"))
with(mydata,smoothScatter(x,y,main="Scatterplot Colored by Smoothed Densities"))
par(mfrow=c(1,1))
# 三维散点图
library(scatterplot3d)
attach(mtcars)
scatterplot3d(wt,disp,mpg,
              main="Basic 3D Scatter Plot")
detach(mtcars)

# 气泡图
attach(mtcars)
r<-sqrt(disp/pi)
symbols(wt,mpg,circle=r,inches=0.30,
        fg="white",bg="lightblue",
        main="Bubble Plot with point size proportional to displacement",
        ylab="Miles Per Gallon",
        xlab="Weight of Car(lbs/1000)")
text(wt,mpg,rownames(mtcars),cex=0.6)
detach(mtcars)

# 线图
type <- c('l','b','c','o','s','S')
par(mfrow=c(2,3))
for(i in 1:6){
  plot(1:10,type=type[i],main=paste0("type=",type[i]))
}
par(mfrow=c(1,1))

# 柱状图
par(mfrow=c(1,2))
for(i in c(FALSE,TRUE)){
  barplot(VADeaths,horiz = i,beside = T,col = rainbow(5))
}

# 绘制直方图
data(economics, package = "ggplot2") 
attach(economics)                      #将economics加载到内存
par(mfrow=c(2,2))
hist(psavert,8,xlab="个人储蓄率",ylab="频数",col="blue",
     main="个人储蓄率直方图（较少区间）")
hist(psavert,30,xlab="个人储蓄率",ylab="频数",col="blue",
     main="个人储蓄率直方图（较多区间）")
hist(uempmed,8,xlab="一周内平均失业持续时间",ylab="频数",col="green",
     main="一周内平均失业持续时间（较少区间）")
hist(uempmed,30,xlab="一周内平均失业持续时间",ylab="频数",col="green",
     main="一周内平均失业持续时间（较多区间）")
par(mfrow=c(1,1))
detach(economics)                 #将economics从内存中释放

# 绘制核密度图
plot(density(economics$psavert))
rug(economics$psavert)

# 箱线图
boxplot(iris$Sepal.Length~iris$Species,col=rainbow(3))
boxplot(iris$Sepal.Length~iris$Species,col=rainbow(3),outline=F)
