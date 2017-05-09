# as is 
methods(is)
methods(as)

#date

Sys.Date()
Sys.time()
date()
as.POSIXlt(date())

#精确度：typeof>class>mode
sapply(df,class)
sapply(lm,mode)
sapply(data.frame,class)
sapply(data.frame,mode)
sapply(data.frame,typeof)

#seq rep
seq(from = 0, to = 10, length.out = 21) #前后都计算在内了
rep(1:4,each=4,times=3)

#factor
chr1 <- c("m", "f", "m", "f")
f1 <- factor(as.character(chr1), ordered=T, levels = c("m","f"), labels = c("male","female")) #levels必须和输入相同，不相同的全部转换为NA
chr2 <- c("male", "female", "male", "female")
f2 <- factor(chr2, ordered=T, levels = c("male","female"))
storage.mode(f)
as.numeric(f)

gender <- gl(2,10,labels = c("male","female"),ordered = T)

m <- matrix(1:10, nrow = 5, dimnames = list(paste0("r",1:5),paste0("c",1:2))) #默认按列填充
m
as.vector(m) #将矩阵拉直
as.vector.factor(f1) #将factor拉直

#list
my.list<-list(stud.id=34453,
              stud.name="jax",
              stud.marks=c(14.3,12,15,19))
l <- unlist(my.list) #将多维拉直
str(l)

#order rank sort
x <- c(3,4,645,576,2,1)
order(x) 
rank(x)
sort(x)

d <- data.frame(x=c(1,1,2,2,3,3,4,4,5,5),y=c(1,2,3,4,5,6,7,8,9,0))
d[order(d$x,-d$y),]

#subset(x,subset,select,...)
subset(airquality,Temp>80,select = -c(Ozone))

#sqldf require会返回逻辑值 而library不会
if(!require(sqldf)){
  install.packages("sqldf")
  require(sqldf)
}
mq <- sqldf("select * from mtcars limit 6")
