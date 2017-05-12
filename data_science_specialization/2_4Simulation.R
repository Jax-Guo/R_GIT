# rnorm: generate random Normal variates with a given mean and standard deviation
# dnorm: evaluate the Normal probability density (with a given mean/SD) at a point (or vector of  points)                                                                                points)
# pnorm: evaluate the cumulative distribution function for a Normal distribution
# rpois: generate random Poisson variates with a given rate

# dnorm(x, mean = 0, sd = 1, log = FALSE)
# pnorm(q, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
# qnorm(p, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE)
# rnorm(n, mean = 0, sd = 1)

set.seed(2017)

#正态分布
rnorm(1,0,1)
pnorm(0,0,1)
qnorm(0.5,0,1)
dnorm(0,0,1)

#泊松分布
rpois(10,1)

#Cumulative distribution
ppois(2,2)

#Generating Random Numbers From a Linear Model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

#Generating Random Numbers From a Binormal Linear Model
set.seed(20)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

#Generating Random Numbers From a Poisson Linear Model
set.seed(20)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x,y)
