# 导入Excel数据
# 利用xlsx包读取EXcel数据
install.packages("xlsx")
library(xlsx)
file<-'sample.xlsx'
res <- read.xlsx(file,1)
res
detach(package:xlsx)