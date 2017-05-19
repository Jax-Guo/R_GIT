install.packages("arules")
library(arules)
data(Groceries)
summary(Groceries)
# 查看前6项交易记录
inspect(Groceries[1:6])
# 也可以利用as函数将数据转换成data.frame格式
head(as(Groceries,"data.frame"))
# itemFrequency( )函数可以看到包含该商品的交易比例。
# 例如Groceries数据中前3件商品的支持度：
itemFrequency(Groceries[,1:3])
# 例如我们查看Groceries数据中商品whole milk、other vegetables的销售占比：
itemFrequency(Groceries[,c("whole milk","other vegetables")])

# 可视化商品的支持度—商品的频率图
# 使用itemFrequencyPlot( )函数
# 如果希望获得那些出现在最小交易比例中的商品，可以在itemFrequencyPlot( )函数中运用support参数：
itemFrequencyPlot(Groceries,support=0.1)
# 在itemFrequencyPlot( )函数中使用topN参数:
itemFrequencyPlot(Groceries,topN=20)

# 基于数据训练模型
# 采用默认设置：support=0.1和confidence=0.8
apriori(Groceries)
# 设置support=0.006,confidence=0.25,minlen=2
groceryrules <- apriori(Groceries,parameter = 
                            list(support=0.006,confidence=0.25,minlen=2))
groceryrules
# 评估模型性能
# 使用summary( )查看更多信息
summary(groceryrules)
# 查看具体规则
inspect(groceryrules[1:3])
# 对关联规则集合排序
inspect(sort(groceryrules,by="lift")[1:5])
# 提取关联规则的子集
berryrules <- subset(groceryrules,items %in% "berries")
inspect(berryrules)
# 关联规则可视化
install.packages("arulesViz")
library(arulesViz)
plot(subset(groceryrules,lift > 3),method="graph")
# 将关联规则保存到文件中
write(groceryrules,file="groceryrules.csv",sep=",",quote=TRUE,row.names=FALSE)

library("arulesViz")
data("Groceries")
summary(Groceries)
# 设置支持度为0.001，置信度为0.5
rules <- apriori(Groceries, parameter = list(support = 0.001, confidence = 0.5))
# 散点图
plot(rules)
# 如果我们想个性化plot图中的坐标的特征，将颜色表示conf，lift为纵标轴
plot(rules, measure = c("support", "lift"), shading = "confidence")
# supp为x轴，conf为y轴，颜色的深浅表示“order”，例如规则里频繁项的个数。
# 从图中可以看出，order和supp有着很强的负相关性。这在关联规则中也是熟知的。
plot(rules, shading = "order", control = list(main = "Two-key plot"))
# 交互
sel <- plot(rules, measure = c("support", "lift"), shading = "confidence",
            interactive = TRUE)

# 基于分组矩阵的可视化
plot(rules, method = "grouped")

# 基于图的可视化
subrules2 <- head(sort(rules, by = "lift"), 10)
plot(subrules2, method = "graph")
plot(subrules2, method = "graph", control = list(type = "items"))

# 平行坐标图
plot(subrules2,method = "paracoord")
