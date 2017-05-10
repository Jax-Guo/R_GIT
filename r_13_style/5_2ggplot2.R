#### ggplot2系统
# 散点图
library(ggplot2)
ggplot(data=mtcars, aes(x=wt, y=mpg)) +
  geom_point() +
  labs(title="Automobile Data", x="Weight", y="Miles Per Gallon")

library(ggplot2)
ggplot(data=mtcars, aes(x=wt, y=mpg)) +
  geom_point(pch=17, color="blue", size=2) +
  geom_smooth(method="lm", color="red", linetype=2) +
  labs(title="Automobile Data", x="Weight", y="Miles Per Gallon")

data(Salaries, package="car")
ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank,
                     shape=sex)) + geom_point()


mtcars$am <- factor(mtcars$am, levels=c(0,1),
                    labels=c("Automatic", "Manual"))
mtcars$vs <- factor(mtcars$vs, levels=c(0,1),
                    labels=c("V-Engine", "Straight Engine"))
mtcars$cyl <- factor(mtcars$cyl)

library(ggplot2)
ggplot(data=mtcars, aes(x=hp, y=mpg,
                        shape=cyl, color=cyl)) +
  geom_point(size=3) +
  facet_grid(am~vs) +
  labs(title="Automobile Data by Engine Type",
       x="Horsepower", y="Miles Per Gallon")

# 柱状图
library(ggplot2)
data(Salaries,package="car")
ggplot(Salaries, aes(x=rank, fill=sex)) +
  geom_bar(position="stack") + labs(title='position="stack"')

ggplot(Salaries, aes(x=rank, fill=sex)) +
  geom_bar(position="dodge") + labs(title='position="dodge"')

ggplot(Salaries, aes(x=rank, fill=sex)) +
  geom_bar(position="fill") + labs(title='position="fill"')

# 直方图
data(singer, package="lattice")
ggplot(singer, aes(x=height)) + geom_histogram()

ggplot(data=singer, aes(x=height)) +
  geom_histogram() +
  facet_wrap(~voice.part, nrow=4)

# 箱线图
library(ggplot2)
qplot(Species,Sepal.Length,data=iris,
      geom="boxplot",fill=Species,
      main="依据种类分组的花萼长度箱线图")

ggplot(iris,aes(x=Species,y=Sepal.Length,fill=Species))+
  geom_boxplot()+
  geom_jitter()+ #添加扰动，防止过拟合
  labs(title="依据种类分组的花萼长度箱线图")

# 小提琴图
qplot(Species,Sepal.Length,data=iris,
      geom=c("violin","jitter"),fill=Species,
      main="依据种类分组的花萼长度小提琴图")

ggplot(iris,aes(x=Species,y=Sepal.Length,fill=Species))+
  geom_violin()+
  geom_jitter()+
  labs(title="依据种类分组的花萼长度箱线图")

# 核密度图
data(singer,package = "lattice")
ggplot(data=singer,aes(x=height,fill=voice.part))+
  geom_density()+
  facet_grid(voice.part~.)

ggplot(data=singer,aes(x=height,fill=voice.part))+
  geom_density()+
  facet_wrap(~voice.part,ncol=4)+
  theme(legend.position="none")

## ggtheme主题
# Economist和Solarized主题
library(ggplot2)
library(ggthemes)
p1 <- ggplot(mtcars, aes(x = wt, y = mpg, colour = factor(gear))) +
  geom_point() 
# Economist themes
p2 <- p1 + ggtitle("Economist theme") +
  theme_economist() + scale_colour_economist() 
# Solarized theme
p3 <- p1 + ggtitle("Solarized theme") + 
  theme_solarized() + scale_colour_solarized("blue")
# The dark theme
p4 <- p1 + ggtitle("The dark theme") +
  theme_solarized(light = FALSE) +
  scale_colour_solarized("red")
# An alternative theme
p5 <- p1 + ggtitle("An alternative theme") +
  theme_solarized_2(light = FALSE) +
  scale_colour_solarized("blue")  
# Stata theme
p6 <- p1 + ggtitle("Stata them") + 
  theme_stata() + scale_colour_stata()
# Excel 2003 theme
p7 <- p1 + ggtitle("Excel 2003  them") + 
  theme_excel() + scale_colour_excel()
# Tableau Scales
p8 <- p1 +  theme_igray() + scale_colour_tableau()
p9 <- p1 + theme_igray() + scale_colour_tableau("colorblind10")
# Inverse Gray Theme
p10 <- p1 + ggtitle("Inverse Gray Theme") + theme_igray() #great
# Highcharts theme
p11 <- p1 + ggtitle("Highcharts theme") +
  theme_hc(bgcolor = "darkunica") +
  scale_colour_hc("darkunica")
# Calc Theme
p12 <- p1 + ggtitle("Calc Theme") +
  theme_calc() + scale_color_calc()
# Wall Street Journal
p13 <- p1 + ggtitle("Wall Street Journal") +
  theme_wsj() + scale_colour_wsj("colors6", "")
