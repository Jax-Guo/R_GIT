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
