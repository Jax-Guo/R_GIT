#模糊搜索
??ada 

#同上
help.search('sp') 

#获取当前目录
getwd()

#获取当前变量的str信息
ls.str()

#模糊搜索
apropos('ada')


#去除na
res1 = na.omit(a)

#vector
seq(1,6)
w <- seq(1:10)

#matrix
(a<-matrix(w,nrow=5,byrow = T,dimnames = list(paste0("r",1:5),paste0("i",1:2))))
cbind(1,a)

#par plot pairs pie 
par(mfrow=c(1,2))
plot(x=rnorm(10))
plot(women)
par(mfrow=c(1,1))
plot(iris[,1:4],main="plot")
pairs(iris[,1:4],main="pairs")
pie(table(mtcars$mpg))

#qq图 用于检测数据是否服从正态分布
qqnorm(mtcars$mpg)
qqline(mtcars$mpg)

#茎叶图
stem(round(mtcars$wt,digits = 1))
stem(mtcars$wt)
stem(mtcars$mpg)

#分位
quantile(mtcars$mpg)

#查看数据信息
summary(mtcars)
library(Hmisc)
describe(mtcars)

#查看函数参数
args(rnorm)
args(plot)

####