library("readxl")
library(caret)
library(tidyverse)

House_price_India <- read_excel("House Price India.xlsx")

#view data
glimpse(House_price_India)
view(House_price_India)

#split 80% 20%
train_test_split <- function(data, trainRatio = 0.8) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, size = trainRatio * n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train_data = train_data, test_data = test_data))
}

split_data <- train_test_split(House_price_India,0.8)
train_data <- split_data$train
test_data <- split_data$test

#train model
lm_model <- train(log(Price) ~ `number of bedrooms` + `number of bathrooms` + `living area` + `condition of the house` + `Distance from the airport` ,
                  data = train_data,
                  method = "lm")

knn_model <- train(log(Price) ~ `number of bedrooms` + `number of bathrooms` + `living area` + `condition of the house` + `Distance from the airport` ,
                   data = train_data,
                   method = "knn")

#score
pred <- predict(lm_model, newdata = test_data)

#evaluate
#RMSE
rmse_metric <- function(actual, prediction){
  sqrt(mean((actual - prediction)**2))
}

#MAE
mae_metric <- function(actual, prediction){
  mean(abs(actual - prediction))
}

#MSE
mse_metric <- function(actual, prediction){
  mean((actual - prediction)**2)
}

rmse_metric(log(test_data$Price),pred)
mae_metric(log(test_data$Price),pred)
mse_metric(log(test_data$Price),pred)
