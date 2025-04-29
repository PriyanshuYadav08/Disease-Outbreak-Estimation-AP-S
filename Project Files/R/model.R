library(e1071)

train_models <- function(X_train, y_train) {
  # Linear Regression
  lr_model <- lm(y_train ~ days, data = data.frame(days = X_train$days, y_train))

  # SVM Model
  svm_model <- svm(y_train ~ days, data = data.frame(days = X_train$days, y_train),
                   kernel = "radial", cost = 100, gamma = 0.1, epsilon = 0.1)

  list(lr = lr_model, svm = svm_model)
}