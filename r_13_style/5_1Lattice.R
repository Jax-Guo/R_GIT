#### lattice系统
# 例子
# 构建简单数据集
d <- data.frame(x=seq(0,14),y=seq(1,15),z=rep(c("a","b","c"),times=5))
# 绘制简单散点图
library(lattice)
xyplot(y~x,data=d)
# 绘制带有条件变量的散点图
library(lattice)
xyplot(y~x|z,data=d)
# 绘制带有分组变量的散点图
library(lattice)
xyplot(y~x,groups = z,data=d)
xyplot(y~x,groups=z,data=d,
       pch=c(1,3,4))
# 显示定制面板函数的散点图
mypanel <- function(...){
  panel.abline(a=1,b=1)
  panel.xyplot(...)
}
xyplot(y~x|z,data=d,
       panel=mypanel)

# 图形参数
op <- trellis.par.get()
names(op)
par("cex")
length(par())
trellis.par.get("axis.text")
trellis.par.set(list(axis.text=list(cex=0.5,col="blue")))
xyplot(y~x,data=d)
trellis.par.set(op)

show.settings()
mysettings <- trellis.par.get()
mysettings$superpose.symbol
mysettings$superpose.symbol$pch <- 1:10
mysettings$superpose.symbol$fill <- "black"
trellis.par.set(mysettings)
show.settings()
xyplot(y~x,groups=z,data=d)

# 条件变量
# equal.count(x,number=,overlap=):将一个连续变量变成一个类似因子类型
(displacement <- equal.count(mtcars$disp,number = 3,overlap = 0))#overlap设置重叠部分
xyplot(mtcars$mpg~mtcars$wt|displacement,
       main = "Miles per Gallon vs. Weight by Engine Displacement",
       xlab = "Weight",ylab = "Mile per Gallon",
       layout = c(3,1),aspect = 1.5)

# 面板函数
displacement<-equal.count(mtcars$disp,number=3,overlap=0)
mypanel<-function(x,y){
  panel.xyplot(x,y,pch=19)
  panel.rug(x,y)
  panel.grid(h=-1,v=-1)
  panel.lmline(x,y,col="red",lwd=1,lty=2)
}

xyplot(mpg~wt|displacement,data=mtcars,main="Miles per Gallon vs. Weight by Engine  
       Displacement",xlab="Weight",ylab="Miles per Gallon",layout=c(3,1),
       panel=mypanel)

# 分组变量
mtcars$transmission<-factor(mtcars$am,levels=c(0,1),labels=c("Automatic","Manual"))
densityplot(~mpg,data=mtcars,groups=transmission,main="MPG Distrubution by TranamissionType",
            xlab="Miles per Gallon",auto.key=TRUE)
xyplot(mpg~wt,data=mtcars,pch=1:3,col=1:3,
       groups = factor(cyl),
       key=list(space="right",points=list(pch=1:3,col=1:3),
                text=list(levels(factor(mtcars$cyl)))))


# 条形图
library(lattice)
str(Titanic) # 查看Titanic数据结构
barchart(Titanic,layout=c(4,1),auto.key=TRUE) # 对table类型画出条形图，data参数不用设置
barchart(Titanic,layout=c(4,1),
         auto.key=TRUE,scales=list(x="free")) #将x轴坐标设置为free
# 将表格数据Tatanic转换成数据框，然后绘制条形图
barchart(Class~Freq|Sex+Age,data=as.data.frame(Titanic),
         groups=Survived,stack=TRUE,layout=c(4,1),
         auto.key=TRUE,scales=list(x="free"))
# 改变图例摆放形式
barchart(Class~Freq|Sex+Age,data=as.data.frame(Titanic),
         groups=Survived,stack=TRUE,layout=c(4,1),
         auto.key=list(title="Survived",columns=2),
         scales=list(x="free"))
# 将lattice的高级绘图函数创建的栅栏图存在mygraph对象中。
mygraph <- barchart(Class~Freq|Sex+Age,data=as.data.frame(Titanic),
                    groups=Survived,stack=TRUE,layout=c(4,1),
                    auto.key=list(title="Survived",columns=2),
                    scales=list(x="free"))
# 通过update函数给mygraph图形增加垂直网格线,并将条形边框设置为透明色
update(mygraph,
       panel=function(...){
         panel.grid(h=0,v=-1)
         panel.barchart(...,border="transparent")
       })

# 点图
# 绘制分组点图
dotplot(VADeaths,pch=1:4,col=1:4,
        main = list("Death Rates in Virginia - 1940",cex=1.5),
        xlab = "Rate (per 1000)",
        key=list(column=4,
                 text=list(colnames(VADeaths)),
                 points=list(pch=1:4,col=1:4)))
# 绘制面板点图
dotplot(VADeaths, groups = FALSE,
        main = list("Death Rates in Virginia - 1940",cex=1.5),
        xlab = "Rate (per 1000)")
# 调整type参数，美化点图
dotplot(VADeaths, groups = FALSE,
        layout=c(4,1),aspect = 0.5,
        origin = 0, type = c("p", "h"),
        main = list("Death Rates in Virginia - 1940",cex=1.3),
        xlab = "Rate (per 1000)")

# 直方图
library(lattice)
library(nutshell)
data(births2006.smpl)
histogram(~DBWT|DPLURAL,data=births2006.smpl,
          main="Births in the United States, 2006",
          xlab="Birth weight, in grams")
# 调整layout参数
histogram(~DBWT|DPLURAL,data=births2006.smpl,layout=c(1,5),
          main="Births in the United States, 2006",
          xlab="Birth weight, in grams")

# 核密度图
densityplot(~DBWT|DPLURAL,data=births2006.smpl,
            layout=c(1,5),plot.points=FALSE,
            main="Births in the United States, 2006",
            xlab="Birth weight, in grams")
# 绘制叠加密度图
densityplot(~DBWT,groups=DPLURAL,data=births2006.smpl,
            plot.points=FALSE,lty=1:5,col=1:5,lwd=1.5,
            main="Births in the United States, 2006",
            xlab="Birth weight, in grams",
            key=list(column=3,
                     text=list(levels(births2006.smpl$DPLURAL)),
                     lines=list(lty=1:5,col=1:5)))

# 带状图
stripplot(~DBWT,data=births2006.smpl,
          subset=(DPLURAL=="5 Quintuplet or highter" |
                    DPLURAL=="4 Quadruplet"),
          jitter.data=TRUE,
          main="Births in the United States, 2006",
          xlab="Birth weight, in grams")

# Q-Q图
# 单变量Q-Q图
library(lattice)
qqmath(~ height | voice.part, aspect = "xy", data = singer,
       prepanel = prepanel.qqmathline,
       panel = function(x, ...) {
         panel.qqmathline(x, ...)
         panel.qqmath(x, ...)
       })
# 生成比较两个分布的Q-Q图
qq(voice.part ~ height, aspect = 1, data = singer,
   subset = (voice.part == "Bass 2" | voice.part == "Tenor 1"))

# 箱线图
# 栅栏箱线图
bwplot( ~ height|voice.part, data=singer, xlab="Height (inches)")
# 分组箱线图
bwplot(voice.part ~ height, data=singer, xlab="Height (inches)")

# 散点图
xyplot(Sepal.Length~Sepal.Width|Species,data=iris)
# 对Petal.Length变量进行分组再画图
xyplot(Sepal.Length~Sepal.Width|cut(Petal.Length,2),data=iris)

# 散点图矩阵
library(lattice)
# 普通散点图矩阵
splom(mtcars[c(1, 3:7)], groups = mtcars$cyl,
      auto.key=TRUE)
# 修改变量名和图例的散点图矩阵 prescale=0表示不显示坐标轴
splom(mtcars[c(1, 3:7)], groups = mtcars$cyl,
      pscales = 0,pch=1:3,col=1:3,
      varnames = c("Miles\nper\ngallon", "Displacement\n(cu. in.)",
                   "Gross\nhorsepower", "Rear\naxle\nratio",
                   "Weight", "1/4 mile\ntime"),
      key = list(columns = 3, title = "Number of Cylinders",
                 text=list(levels(factor(mtcars$cyl))),
                 points=list(pch=1:3,col=1:3)))

# 三维水平图
library(lattice)
data(Cars93, package = "MASS")
cor.Cars93 <-
  cor(Cars93[, !sapply(Cars93, is.factor)], use = "pair")
levelplot(cor.Cars93,
          scales = list(x = list(rot = 90)))


# 三维等高线图
contourplot(volcano, cuts = 20, label = FALSE)

# 三维散点图
par.set <-list(axis.line = list(col = "transparent"),
               clip = list(panel = "off"))
cloud(Sepal.Length ~ Petal.Length * Petal.Width,data = iris, 
      cex = .8,pch=1:3,col=c("blue","red","green"),
      groups = Species,screen = list(z = 20, x = -70, y =0),
      par.settings = par.set,
      scales = list(col = "black"),
      key=list(title="Species",
               column=3,
               space="bottom",
               text=list(levels(iris$Species)),
               points=list(pch=1:3,col=c("blue","red","green"))))

# 三维曲面图
wireframe(volcano, shade = TRUE,
          aspect = c(61/87, 0.4),
          light.source = c(10,0,10))
