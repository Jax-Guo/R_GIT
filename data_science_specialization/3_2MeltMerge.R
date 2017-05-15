
#melt and dcast
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"),variable.name="varia")
mtcars_dcast <- dcast(carMelt,carname+gear+cyl~varia)
mtcars_dcast <- dcast(carMelt,cyl~varia,fun=mean)

#merge join
library(plyr)
df1 <- data.frame(id=sample(1:10),x=rnorm(10))
df2 <- data.frame(id=sample(1:10),x=rnorm(10))
df3 <- data.frame(id=sample(1:10),z=rnorm(10))

mer_df <- merge(df1,df2,all = T)
mer_df2 <- merge(df1,df2,by="id",all = T)
join_df <- join(df1,df2)#若列相同，只取第一个数据的值
join_df <- join(df1,df3)
join_all(list(df1,df2,df3))
