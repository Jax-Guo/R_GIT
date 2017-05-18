#回归
attach(women)
fit <- lm(weight ~ height)
summary(fit)
coefficients(fit)
vcov(fit)
AIC(fit)
plot(fit)
fitted(fit)
corr.test(fit$fitted.values,weight)

#逐步回归调试
fit2 <- lm(Murder~.,data = states)
summary(fit2)
fit2.step <- step(fit2)
summary(fit2.step)

#多元回归
par(mfrow=c(2,2))
plot(fit)
par(mfrow=c(1,1))
fit3 <- lm(weight~height+I(height^2))
summary(fit3)
par(mfrow=c(2,2))
plot(fit3)
par(mfrow=c(1,1))

#逻辑回归
# logistic回归在glm中属于binomial族，默认连接函数(link)为logit函数:
setwd(paste0(getwd(),"/","r_13_style"))
w2=read.table("column.2C.dat")
ch=lm(V6~.,w2[-116,])
w2[116,6]=predict(ch,w2[116,-6]) # 50.79539
a=glm(V7~.,w2,family="binomial")
b=step(a) #做逐步回归筛选变量
summary(b) #输出回归系数
# 由于拟合结果是给每个观测值一个概率值，下面以0.05作为分类界限：
z=(predict(b,w2,type="response")>0.5)
u=rep("NO",310);u[!z]="AB" # 把预测结果转换成原先的值(AB或NO)
(zz=table(w2[,7],u))  # 2乘2矩阵，对角线外的数目为分错的数目
(sum(zz)-sum(diag(zz)))/sum(zz) # 计算错判率
