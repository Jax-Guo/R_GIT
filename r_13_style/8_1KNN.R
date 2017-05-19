#### 利用KNN近邻分类算法对iris数据集进行分类
# 数据抽样
library(caret)
index <- createDataPartition(iris$Species,times = 1,p = 0.5,list = F) # 按照Species变量等比例抽取50%的下标集最为训练集数据
# 数据分区
train <- iris[index,] # 训练集
test <- iris[-index,] # 测试集
# 利用KNN算法对测试集的类别进行分类
library(class)
a <- knn(train[,1:4],test[,1:4],train[,5],k=3) # 选择三个邻居

# 自定义函数实现KNN算法流程
ceshi <- function(n=1,k=3){
    # 求待分类样本与已经样本的欧式距离
    x <- (test[rep(n,nrow(train)),1:4]-train[,1:4])^2
    myfun <- function(x){
        sqrt(sum(x))
    }
    train$dist <- apply(x,1,myfun)
    # 对距离进行排序，选取最近的k个邻居
    mydata <- train[order(train$dist)[1:k],5:6]
    # 提取最大占比的类别
    result <- data.frame(sort(table(mydata$Species),decreasing = T))
    Species <- result[1,1]
    return(list(Species,mydata))
}
ceshi(n=73,k=5)

# 查看分类结果的误差率
t <- table(test$Species,a)
paste0(round((sum(t)-sum(diag(t)))*100/sum(t),2),"%")


### 案例二：用KNN算法诊断乳腺癌
# 导入数据
wbcd <- read.csv("wisc_bc_data.csv",header = F)
# 对列名进行重命名
colnames(wbcd) <- c("id","y",paste0("x",1:30))
# 移除id列数据
wbcd <- wbcd[,-1]
# 数据探索
summary(wbcd)
# 对数据进行归一化处理
normalize <- function(x){
    (x-min(x))/(max(x)-min(x))
}
wbcd_new <- as.data.frame(apply(wbcd[,2:31],2,normalize))
wbcd_new$y <- wbcd$y
# 数据分区，80%作为训练集，剩下的20%作为测试集
index <- createDataPartition(wbcd_new$y,times = 1,p=0.8,list = F)
train <- wbcd_new[index,]
test <- wbcd_new[-index,]
# 利用KNN算法对肿块是良性还是恶性进行预测
b <- knn(train[,1:30],test[,1:30],train[,31],k=floor(sqrt(nrow(train))))
# 构建混淆矩阵，查看误差率
(t <- table(test$y,b))
paste0(round((sum(t)-sum(diag(t)))/sum(t),2)*100,"%")


#### 案例三：用KNN算法对汽车类型进行识别
# 导入数据
xaa <- read.table("xaa.dat") #训练集
xab <- read.table("xab.dat") #测试集
# 对列进行重命名
colnames(xaa) = colnames(xab) <- c(paste0("x",1:18),"y")
# 查看数据描述性统计分析
summary(xaa)
# 发现异常值，我们利用boxplot.stats函数对x15变量的异常值进行剔除
xaa_clean <- xaa[!xaa$x15 %in% boxplot.stats(xaa$x15)$out,]
