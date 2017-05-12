# 数据的获取和整合
# 导入数据 
traindata <- read.csv("cs-training.csv")
# 剔除id列
traindata <- traindata[,-1]
# 对变量进行重新命名
colnames(traindata) <- c('y',paste0('x',1:10))
# 查看数据结构
str(traindata)

# 缺失值处理
# 查看缺失值模式
library(mice)
library(VIM)
md.pattern(traindata)
aggr(traindata,prop=F,numbers=T)
matrixplot(traindata)
# # 因为缺失值所占比例较高，直接移除会损失大量观测，因此并不是最合适的方法。在这里，我们使用KNN方法对缺失值进行填补。
# library(DMwR)
# traindata <- knnImputation(traindata,k=10,meth = "weighAvg")
# # 随机森林插补法
# library(missForest)
# mis.model <- missForest(traindata)
# 中位数替补法
library(caret)
imputation_m <- preProcess(traindata,method = "medianImpute")
traindata <- predict(imputation_m,traindata)
str(traindata)

# 异常值分析及处理
unique(traindata$x2)
# 可以看到年龄中存在0值，显然是异常值，予以剔除。
traindata <- traindata[!traindata$x2==0,]
# 查看x3、x7、x9三个变量的箱线图
par(mfrow=c(1,3))
for(i in c(4,8,10)){
  boxplot(traindata[,i],col=i,main=colnames(traindata)[i])
}
par(mfrow=c(1,1))

unique(traindata[,4])
# 剔除最大的两个值
for(i in c(4,8,10)){
  x <- sort(traindata[,i],decreasing=T)
  x <- data.frame(table(x))
  x <- x[sort(x$x,decreasing = T),]
  x <- x[1:2,1]
  traindata <- traindata[!traindata[,i] %in% x,]
}

# 变量分析
library(ggplot2)
ggplot(traindata, aes(x = x2, y = ..density..)) + 
  geom_histogram(fill = "blue", colour = "grey60", size = 0.2, alpha = 0.2) +
  geom_density()
ggplot(traindata, aes(x = x5, y = ..density..)) + 
  geom_histogram(fill = "blue", colour = "grey60", size = 0.2, alpha = 0.2) + 
  geom_density() + xlim(1, 20000)

library(corrplot)
cor1 <- cor(traindata)
corrplot(cor1)
corrplot(cor1,method = "number")

# 数据分区
table(traindata$y)
prop.table(table(traindata$y))
library(caret)
set.seed(1234) 
splitIndex<-createDataPartition(traindata$y,time=1,p=0.5,list=FALSE) 
train<-traindata[splitIndex,] 
test<-traindata[-splitIndex,] 
prop.table(table(train$y)) 
prop.table(table(test$y)) 

# 建立逻辑回归模型
fit <- glm(y~.,train,family = "binomial")
summary(fit)
fit.step <- step(fit)
summary(fit.step)

# 模型评估
pre <- predict(fit.step,test)
library(pROC)
modelroc <- roc(test$y,pre)
plot(modelroc, print.auc=TRUE, auc.polygon=TRUE, grid=c(0.1, 0.2),
     grid.col=c("green", "red"), max.auc.polygon=TRUE,
     auc.polygon.col="skyblue", print.thres=TRUE)
# 最优点FPR=1-TNR=0.837，TPR=0.649，AUC值为0.813，说明该模型的预测效果还是不错的，正确较高。

## WOE转换
# 通过上述的Logistic回归，剔除x1,x4,x6三个变量，对剩下的变量进行WOE转换。
# 进行分箱
# age变量(x2)：
cutx2= c(-Inf,30,35,40,45,50,55,60,65,75,Inf)
plot(cut(train$x2,cutx2))
# NumberOfTime30-59DaysPastDueNotWorse变量(x3)：
cutx3 = c(-Inf,0,1,3,5,Inf)
plot(cut(train$x3,cutx3))
# MonthlyIncome变量(x5)：
cutx5 = c(-Inf,1000,2000,3000,4000,5000,6000,7500,9500,12000,Inf)
plot(cut(train$x5,cutx5))
# NumberOfTimes90DaysLate变量(x7)：
cutx7 = c(-Inf,0,1,3,5,10,Inf)
plot(cut(train$x7,cutx7))
# NumberRealEstateLoansOrLines变量(x8)：
cutx8= c(-Inf,0,1,2,3,5,Inf)
plot(cut(train$x8,cutx8))
# NumberOfTime60-89DaysPastDueNotWorse变量(x9)：
cutx9 = c(-Inf,0,1,3,5,Inf)
plot(cut(train$x9,cutx9))
# NumberOfDependents变量(x10)：
cutx10 = c(-Inf,0,1,2,3,5,Inf)
plot(cut(train$x10,cutx10))
# 计算WOE值


