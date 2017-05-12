# rCharts包
# 小例子
install.packages("devtools")
require(devtools) 
install_github('rCharts', 'ramnathv') 
library(rCharts)
names(iris) = gsub("\\.", "", names(iris))
p1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
p1
# nPlot函数
# 柱状图
library(rCharts)
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == "Male")
hair_eye_male[,1] <- paste0("Hair",hair_eye_male[,1])
hair_eye_male[,2] <- paste0("Eye",hair_eye_male[,2])
n1 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
            type = "multiBarChart")
# 条形图
n2 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
            type="multiBarHorizontalChart")
n2
n3 <- nPlot(Freq ~ Hair, group = "Eye", data = hair_eye_male, 
            type="multiBarHorizontalChart")
n3$chart(showControls = F)
n3
# 饼图
n4 <- nPlot(~ cyl, data = mtcars, type = 'pieChart')
n4
n5 <- nPlot(~ cyl, data = mtcars, type = 'pieChart')
n5$chart(donut=TRUE)
n5
# 散点图
n6 <- nPlot(mpg ~ wt, group = 'cyl', data = mtcars, type = 'scatterChart')
n6$xAxis(axisLabel = 'Weight')
n6

# hPlot函数
library(rCharts)
# 气泡图
a <- hPlot(Pulse ~ Height, data = MASS::survey, type = "bubble",
           title = "Zoom demo", subtitle = "bubble chart",
           size = "Age", group = "Exer")
a$colors('rgba(223, 83, 83, .5)', 'rgba(119, 152, 191, .5)', 
         'rgba(60, 179, 113, .5)')
a$chart(zoomType = "xy")
a$exporting(enabled = T)
a
# 饼图
x <- data.frame(key = c("a", "b", "c"), value = c(1, 2, 3))
hPlot(x = "key", y = "value", data = x, type = "pie")
# 混合图
hPlot(freq ~ Exer, data = plyr::count(MASS::survey, c('Sex', 'Exer')), 
      type = c('column', 'line'), group = 'Sex')

# mPlot函数
# 线图
data(economics, package = 'ggplot2')
dat <- transform(economics, date = as.character(date))
p1 <- mPlot(x = "date", y = list("psavert", "uempmed"), data = dat, type = 'Line',
            pointSize = 0, lineWidth = 1)
p1
# 面积图
p1$set(type="Area")
p1
# 柱状图
haireye <- as.data.frame(HairEyeColor)
dat <- subset(haireye, Sex == "Female" & Eye == "Blue")
p2 <- mPlot(x = 'Hair', y = list('Freq'), data = dat, type = 'Bar', labels = list("Count"))
p2
# 混合柱状图
dat <- subset(haireye, Sex == "Female")
p3 <- mPlot(Freq ~ Eye, group = "Hair", data = dat, type = "Bar", labels = 1:4)
p3


# recharts包
if (!require(devtools)) library(devtools)
install_github("madlogos/recharts")
# 散点图
library(recharts)
echartr(iris, Sepal.Length, Sepal.Width, series = Species)
# 如果指定series，就会产生一幅分组散点图。
echartr(mtcars, wt, mpg, factor(am, labels=c('Automatic', 'Manual')))
# 气泡图
# 如果指定weight，并设type为bubble，就生成一幅气泡图。
echartr(mtcars, wt, mpg, am, weight=gear, type='bubble')

# 条图
titanic <- data.table::melt(apply(Titanic, c(1,4), sum))
names(titanic) <- c('Class', 'Survived', 'Count')
knitr::kable(titanic)
# 单个数据系列Singular Series
# type可以是’hbar’、‘bar’或’auto’。
echartr(titanic[titanic$Survived=='Yes',], Class, Count) %>%
  setTitle('Titanic: N Survival by Cabin Class')
# 多个数据系列Multiple Series
echartr(titanic, Class, Count, Survived) %>%
  setTitle('Titanic: Survival Outcome by Cabin Class')
#  堆积条图Stacked Horizontal Bar Chart
# 相比于hbar，你需要设置subtype为’stack’。
echartr(titanic, Class, Count, Survived, type='vbar', subtype='stack') %>%
  setTitle('Titanic: Survival Outcome by Cabin Class') 

# 雷达图
cars = mtcars[c('Merc 450SE','Merc 450SL','Merc 450SLC'),
              c('mpg','disp','hp','qsec','wt','drat')]
cars$model <- rownames(cars)
cars <- data.table::melt(cars, id.vars='model')
names(cars) <- c('model', 'indicator', 'Parameter')
knitr::kable(cars)
# 多个雷达图Multiple Radars
echartr(cars, c(indicator, model), Parameter, type='radar', sub='fill') %>%
  setTitle('Merc 450SE  vs  450SL  vs  450SLC')
# 带时间轴With Timeline
# 设置z，获得带时间轴的雷达图。
echartr(cars, indicator, Parameter, z=model, type='radar') %>%
  setTitle('Merc 450SE  vs  450SL  vs  450SLC')

# rbokeh包
# 绘制散点图
install.packages("rbokeh")
library(rbokeh)
z <- lm(dist ~ speed, data = cars)
p <- figure(width = 600, height = 600) %>%
  ly_points(cars, hover = cars) %>%
  ly_lines(lowess(cars), legend = "lowess") %>%
  ly_abline(z, type = 2, legend = "lm")
p
# 绘制直方图
h <- figure(width = 600, height = 400) %>%
  ly_hist(eruptions, data = faithful, breaks = 40, freq = FALSE) %>%
  ly_density(eruptions, data = faithful)
h
# 绘制箱线图
figure(ylab = "Height (inches)", width = 600) %>%
  ly_boxplot(voice.part, height, data = lattice::singer)

# plotly包
# 散点图
rm(list=ls())
install.packages("plotly")
library(plotly)
p <- plot_ly(iris, x = iris$Petal.Length, y = iris$Petal.Width,
             color = iris$Species, colors = "Set1", mode = "markers")
p
# 箱线图
library(plotly)
plot_ly(midwest, x = percollege, color = state, type = "box")
# 利用ggplot2绘图
library(plotly)
p <- ggplot(data=lattice::singer,aes(x=height,fill=voice.part))+
  geom_density()+
  facet_grid(voice.part~.)
(gg <- ggplotly(p))

# dygraphs包
install.packages("dygraphs")
library(dygraphs)
lungDeaths <- cbind(mdeaths, fdeaths)
dygraph(lungDeaths) %>%
  dySeries("mdeaths", label = "Male") %>%
  dySeries("fdeaths", label = "Female") %>%
  dyOptions(stackedGraph = TRUE) %>%
  dyRangeSelector(height = 20)

# DT包
library(DT)
datatable(iris)

# networkD3包
install.packages("networkD3")
library(networkD3)
# 利用simpleNetwork函数绘制简单网络图
library(networkD3)
src <- c("A", "A", "A", "A",
         "B", "B", "C", "C", "D")
target <- c("B", "C", "D", "J",
            "E", "F", "G", "H", "I")
networkData <- data.frame(src, target)
simpleNetwork(networkData)
simpleNetwork(networkData,zoom=T)
# 利用forceNetwork函数绘制力导向网络图
# 加载数据
data(MisLinks)
data(MisNodes)
# 画图
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name",
             Group = "group", opacity = 0.8,zoom=T)
