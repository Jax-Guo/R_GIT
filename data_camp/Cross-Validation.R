if(!require(caret)){
  install.packages("caret")
}
str(mtcars)
model <- train(mpg~., mtcars, method = "lm", 
               trControl = trainControl(method = "cv", number = 10, verboseIter = T)
              )
prevaule <- predict(model,mtcars)

RMSE <- sqrt(mean((prevaule - mtcars$mpg)^2))

RMSE
