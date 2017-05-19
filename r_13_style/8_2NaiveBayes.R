# 导入数据
sms_raw <- read.csv("english_big.csv")
str(sms_raw)
sms_raw$type <- factor(sms_raw$type)
str(sms_raw)
table(sms_raw$type)
prop.table(table(sms_raw$type))

# 数据准备-处理和分析文本数据
library(tm)
# 创建一个语料库
sms_corpus <- Corpus(VectorSource(sms_raw$text))
print(sms_corpus)
# 函数tm_map提供了一种用来转换tm预料库的方法：
corpus_clean <- tm_map(sms_corpus,content_transformer(tolower))
corpus_clean <- tm_map(corpus_clean,PlainTextDocument)
corpus_clean <- tm_map(corpus_clean,removeNumbers)
corpus_clean <- tm_map(corpus_clean,removeWords,stopwords())
corpus_clean <- tm_map(corpus_clean,removePunctuation)
corpus_clean <- tm_map(corpus_clean,stripWhitespace)
# 创建稀疏矩阵
sms_dtm <- DocumentTermMatrix(corpus_clean)

# 建立训练集和测试集数据集
# 把数据随机分成两部分：75%训练集、25%测试集
index <- sample(1:dim(sms_raw)[1],0.75*nrow(sms_raw),replace = F)
sms_raw_trian <- sms_raw[index,]
sms_raw_test <- sms_raw[-index,]
# 输出文档-词条矩阵
sms_dtm_train <- sms_dtm[index,]
sms_dtm_test <- sms_dtm[-index]
# 最后，得到语料库
sms_corpus_trian <- corpus_clean[index]
sms_corpus_test <- corpus_clean[-index]
# 词云展示
library(wordcloud)
wordcloud(sms_corpus_trian,min.freq = 25,random.order = FALSE)
# 把稀疏矩阵转换成可用于朴素贝叶斯可识别的数据结构
# 查找频繁出现的单词需要用到tm包有一个函数findFreqTerms函数
findFreqTerms(sms_dtm_train,5)
# 为了保存这个频繁出现的单词列表，我们构建Dictionary函数：
Dictionary <- function(x){
    if(is.character(x)){
        return(x)
    }
    strop("x is not character vector")
}
sms_dict <- Dictionary(findFreqTerms(sms_dtm_train,5))
sms_trian <- DocumentTermMatrix(sms_corpus_trian,list(dictionary=sms_dict))
sms_test <- DocumentTermMatrix(sms_corpus_test,list(dictionary=sms_dict))
# 自定义函数convert_counts函数，实现计数转换成因子：
convert_counts <- function(x){
    x <- ifelse(x>0,1,0)
    x <- factor(x,levels = c(0,1),labels = c("No","Yes"))
    return(x)
}
sms_trian <- apply(sms_trian,2,convert_counts)
sms_test <- apply(sms_test,2,convert_counts)

# 建立模型，并对测试集数据进行分类预测，验证模型效果
library(e1071)
model <- naiveBayes(sms_trian,sms_raw_trian$type)
pred <- predict(model,sms_test)
t <- table(sms_raw_test$type,pred)
paste0(round((sum(t)-sum(diag(t)))*100/sum(t),2),"%")
