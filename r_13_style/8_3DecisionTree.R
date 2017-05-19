#### C5.0决策树算法
# 导入汽车数据集
xaa <- read.table("xaa.dat")
xab <- read.table("xab.dat")
library(C50)
mod <- C5.0(xaa$V19 ~ .,data=xaa)
mod
summary(mod)
# 利用predict()函数对训练集数据进行预测，并计算其混淆矩阵：
pred <- predict(mod,xab,type="class")
(a=table(xab$V19,pred))
(b=paste0(round((sum(a)-sum(diag(a)))/sum(a),4)*100,"%"))

#### CART决策树算法
## 利用CART算法识别汽车类型
library(rpart)
(b=rpart(xaa$V19~.,data=xaa))
# 基于此数据的结果画出决策树的树状图
plot(b);text(b)
library(rattle)
fancyRpartPlot(b)
# 利用predict()函数对训练集数据进行预测，并计算其混淆矩阵：
pred <- predict(b,xab,type="class")
(a=table(xab$V19,pred))
(b=paste0(round((sum(a)-sum(diag(a)))/sum(a),4)*100,"%"))

## 利用CART判断汽车的舒适度
# 导入car数据集
car <- read.table("car.data",sep = ",")
# 对变量重命名
colnames(car) <- c("buy","main","doors","capacity","lug_boot","safety","accept")
# 查看数据结构
str(car)
# 数据分区，按照变量accept变量进行等比抽样，80%为训练集，20%为测试集
library(caret)
ind <- createDataPartition(car$accept,times=1,p=0.8,list=F) # 训练集下表
train <- car[ind,] # 训练集
test <- car[-ind,] # 测试集
# 查看变量accept各因子占比
prop.table(table(car$accept))
prop.table(table(train$accept))
prop.table(table(test$accept))
# 构建分类模型
mod <- rpart(train$accept~.,data=train)
# 对测试集数据进行预测
pred <- predict(mod,test,type="class")
pred
# 构建混淆矩阵，查看预测效果
# 查看训练集的误差率
(a <- table(train$accept,predict(mod,train,type="class")))
paste0(round((sum(a)-sum(diag(a)))/sum(a),4)*100,"%")
# 查看测试集的误差率
(b <- table(test$accept,predict(mod,test,type="class")))
paste0(round((sum(b)-sum(diag(b)))/sum(b),4)*100,"%")

#### 条件推理决策树算法
## 利用条件推理决策树算法识别汽车类型
library(party)
model1 <- ctree(xaa$V19~.,data=xaa)
model1
plot(model1)
# 构建混淆矩阵，查看模型评估效果
# 对训练集构建混淆矩阵，查看误差率
(a <- table(xaa$V19,predict(model1,xaa)))
paste0(round((sum(a)-sum(diag(a)))/sum(a),4)*100,"%")
# 查看测试集的误差率
(b <- table(xab$V19,predict(model1,xab)))
paste0(round((sum(b)-sum(diag(b)))/sum(b),4)*100,"%")

## 利用条件推理决策树算法识别汽车类型
model2 <- ctree(train$accept~.,data=train)
model2
# 构建混淆矩阵，查看模型评估效果
# 对训练集构建混淆矩阵，查看误差率
(a <- table(train$accept,predict(model2,train)))
paste0(round((sum(a)-sum(diag(a)))/sum(a),4)*100,"%")
# 查看测试集的误差率
(b <- table(test$accept,predict(model2,test)))
paste0(round((sum(b)-sum(diag(b)))/sum(b),4)*100,"%")


