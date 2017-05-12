#散点图矩阵
install.packages("car")
library(car)
scatterplotMatrix(mtcars[,3:7])


library(lattice)
splom(mtcars[,3:7],groups = mtcars$cyl,auto.key=T)
splom(mtcars[c(1, 3:7)], groups = mtcars$cyl,
      pscales = 0,pch=1:3,col=1:3,
      varnames = c("Miles\nper\ngallon", "Displacement\n(cu. in.)",
                   "Gross\nhorsepower", "Rear\naxle\nratio",
                   "Weight", "1/4 mile\ntime"),
      key = list(columns = 3, title = "Number of Cylinders",
                 text=list(levels(factor(mtcars$cyl))),
                 points=list(pch=1:3,col=1:3)))

#相关系数
cor.test(mtcars$mpg,mtcars$disp)
install.packages("psych")
library(psych)
corr.test(mtcars[,c(1,3:7)])

install.packages("corrgram")
library(corrgram)
corrgram(mtcars[,c(1,3:7)],order=TRUE,lower.panel=panel.shade,
         upper.panel=panel.pie,text.panel=panel.txt,
         main="Correlogram of mtcars intercorrelations")

install.packages("corrplot")
library(corrplot)
M <- cor(mtcars[,c(1,3:7)])
corrplot(M)
corrplot.mixed(M, lower = "ellipse", upper = "number",tl.pos="lt",diag="u") 
