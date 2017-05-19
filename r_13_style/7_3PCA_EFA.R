# 主成分分析
# 例1：中学生身体四项指标的主成分分析
#### 用数据框形式输入数据
student<-data.frame(
    X1=c(148, 139, 160, 149, 159, 142, 153, 150, 151, 139, 
         140, 161, 158, 140, 137, 152, 149, 145, 160, 156, 
         151, 147, 157, 147, 157, 151, 144, 141, 139, 148), 
    X2=c(41, 34, 49, 36, 45, 31, 43, 43, 42, 31, 
         29, 47, 49, 33, 31, 35, 47, 35, 47, 44,
         42, 38, 39, 30, 48, 36, 36, 30, 32, 38),
    X3=c(72, 71, 77, 67, 80, 66, 76, 77, 77, 68, 
         64, 78, 78, 67, 66, 73, 82, 70, 74, 78, 
         73, 73, 68, 65, 80, 74, 68, 67, 68, 70),
    X4=c(78, 76, 86, 79, 86, 76, 83, 79, 80, 74, 
         74, 84, 83, 77, 73, 79, 79, 77, 87, 85, 
         82, 78, 80, 75, 88, 80, 76, 76, 73, 78)
)
#### 作主成分分析
student.pr<-princomp(student, cor=TRUE)
#### 并显示分析结果
summary(student.pr, loadings=TRUE)
#### 作预测
predict(student.pr)
#### 画碎石图
screeplot(student.pr)
screeplot(student.pr,type="lines")
biplot(student.pr)
## princomp(~X1+X2+X3+X4,data=student, cor=T)

# 例2：主成分分类
#### 输入数据, 按下三角输入, 构成向量
x<-c(1.00, 
     0.79, 1.00, 
     0.36, 0.31, 1.00, 
     0.96, 0.74, 0.38, 1.00, 
     0.89, 0.58, 0.31, 0.90, 1.00, 
     0.79, 0.58, 0.30, 0.78, 0.79, 1.00, 
     0.76, 0.55, 0.35, 0.75, 0.74, 0.73, 1.00, 
     0.26, 0.19, 0.58, 0.25, 0.25, 0.18, 0.24, 1.00,
     0.21, 0.07, 0.28, 0.20, 0.18, 0.18, 0.29,-0.04, 1.00,
     0.26, 0.16, 0.33, 0.22, 0.23, 0.23, 0.25, 0.49,-0.34, 1.00, 
     0.07, 0.21, 0.38, 0.08,-0.02, 0.00, 0.10, 0.44,-0.16, 0.23, 
     1.00, 
     0.52, 0.41, 0.35, 0.53, 0.48, 0.38, 0.44, 0.30,-0.05, 0.50, 
     0.24, 1.00, 
     0.77, 0.47, 0.41, 0.79, 0.79, 0.69, 0.67, 0.32, 0.23, 0.31, 
     0.10, 0.62, 1.00, 
     0.25, 0.17, 0.64, 0.27, 0.27, 0.14, 0.16, 0.51, 0.21, 0.15, 
     0.31, 0.17, 0.26, 1.00, 
     0.51, 0.35, 0.58, 0.57, 0.51, 0.26, 0.38, 0.51, 0.15, 0.29, 
     0.28, 0.41, 0.50, 0.63, 1.00, 
     0.21, 0.16, 0.51, 0.26, 0.23, 0.00, 0.12, 0.38, 0.18, 0.14, 
     0.31, 0.18, 0.24, 0.50, 0.65, 1.00)
#### 输入变量名称
names<-c("X1", "X2", "X3", "X4", "X5", "X6", "X7", "X8", "X9",  
         "X10", "X11", "X12", "X13", "X14", "X15", "X16")
#### 将矩阵生成相关矩阵
R<-matrix(0, nrow=16, ncol=16, dimnames=list(names, names))
for (i in 1:16){
    for (j in 1:i){
        R[i,j]<-x[(i-1)*i/2+j]; R[j,i]<-R[i,j]
    }
}
#### 作主成分分析
pr<-princomp(covmat=R); load<-loadings(pr)
#### 画散点图
plot(load[,1:2]); text(load[,1], load[,2], adj=c(-0.4, 0.3))

# 例3：PCA:构建股票市场指数
library(ggplot2)
prices<-read.csv("stock_prices.csv")
head(prices)
# 把数据集中的时间戳转换为正确编码的日期变量
library(lubridate)
prices<-transform(prices,Date=ymd(Date))
head(prices)
# 使用reshape包中的cast函数，创建与前面表格相似的数据矩阵。
library(reshape)
date.stock.matrix<-cast(prices,Date~Stock,value="Close")
head(date.stock.matrix)
# 发现有两条记录存在缺失值
sum(!complete.cases(date.stock.matrix))
# 查看含有缺失值的记录
date.stock.matrix[!complete.cases(date.stock.matrix),]
# 删除含有缺失值的数据
prices <- subset(prices, Date != ymd('2002-02-01'))
prices <- subset(prices, Stock != 'DDR')
date.stock.matrix <- cast(prices, Date ~ Stock, value = 'Close')
# 可以使用cor函数来找到这个矩阵中所有数字列之间的相关性
(cor.matrix<-cor(date.stock.matrix[,2:ncol(date.stock.matrix)]))
correlations<-as.numeric(cor.matrix)
ggplot(data.frame(Correlation = correlations),
       aes(x = Correlation, fill = 1)) +
    geom_density() +
    theme(legend.position = 'none')
# 大部分相关性是正数，因此PCA适用于这份数据集
pca<-princomp(date.stock.matrix[,2:ncol(date.stock.matrix)])
pca
# 通过观察第一主成分的载荷量(loadings)来更加细致地研究它。
principal.component <- pca$loadings[, 1]
# 分析载荷的密度图
loadings <- as.numeric(principal.component)
ggplot(data.frame(Loading = loadings),
       aes(x = Loading, fill = 1)) +
    geom_density() +
    theme(legend.position = 'none')
# 到目前为止我们已经获得了主成分，接下来可以把数据总结成一列了。可以使用predict函数完成这个目标：
market.index<-predict(pca)[,1]
# 如何才能知道这些预测值的效果呢？我们使用道琼斯指数(Dow Jones Index)DJI
dji.prices<-read.csv("DJI.csv")
dji.prices<-transform(dji.prices,Date=ymd(Date))
# 取一个子集，仅仅获得我们感兴趣的那些日期
dji.prices<-subset(dji.prices,Date>ymd('2001-12-31'))
dji.prices<-subset(dji.prices,Date!=ymd('2002-02-01'))
# 然后，提取DJI感兴趣的部分，也就是每日收盘价格和我们记录过的那些日期，因为它们的顺序和我们现在的数据集相反，用rev函数反转它们
dji<-with(dji.prices,rev(Close))
dates<-with(dji.prices,rev(Date))
# 现在，我们可以绘制一些简单的图，将使用PCA生成的市场指数和DJI相比较：
comparison<-data.frame(Date=dates,MarketIndex=market.index,DJI=dji)
ggplot(comparison,aes(x=MarketIndex,y=DJI))+
    geom_point()+
    geom_smooth(method="lm",se=FALSE)
# 从图看出，那些之前看上去烦人的负载荷，真的成了麻烦的源头：我们的指数和DJI负相关。
# 但是，我们可以很容易地解决这个麻烦。只需要对指数乘以-1，即可生成一个和DJI正相关的指数.
comparison<-transform(comparison,MarketIndex=-1*MarketIndex)
# 现在可以再一次尝试进行比较了：
ggplot(comparison,aes(x=MarketIndex,y=DJI))+
    geom_point()+
    geom_smooth(method="lm",se=FALSE)
# 我们已经修正了指数的方向，并且它看上去和DJI真的很匹配。

#  因子分析
# 下面因子分析时默认旋转rotation="varimax"
w=read.csv("LA.Neighborhoods.csv") #读入数据
w$density=w$Population/w$Area      #增加人口密度变量
u=w[,-c(12:15)] #去掉人口、面积、经纬度变量
(a=factanal(factors=2,scale(u[,-1]),scores="regression"))
(a$loadings);(a$scores)
plot(a$loadings[,1:2],type="n",ylim=c(-1.1,1.1),
     xlim=c(-1.1,1.2),xlab="Factor 1",ylab="Facor 2",
     main="Loadings")
abline(h=0);abline(v=0)
text(a$loadings[,1],a$loadings[,2],
     labels=row.names(a$loadings),cex=1)
plot(a$scores[,1:2],type="n",ylim=c(-2,1.5),xlim=c(-2.5,2.5),
     xlab="Factor 1",ylab="Factor 2",main="Factor Scores")
abline(h=0);abline(v=0)
text(a$scores[,1],a$scores[,2],labels=u[,1],cex=0.7)

# 对应分析
library(MASS)
v=caith  #数据来源
colnames(v)=paste(colnames(v),"hair")
rownames(v)=paste(rownames(v),"eye")
(cc=corresp(v,nf=2)) #对应分析集结果输出
biplot(cc) #画图
