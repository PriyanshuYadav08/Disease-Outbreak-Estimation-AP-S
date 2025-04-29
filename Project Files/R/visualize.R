library(ggplot2)

plot_predictions <- function(svm_model, lr_model, X_test, y_test) {
  X <- X_test$days
  actual <- y_test

  df <- data.frame(
    days = X,
    actual = actual,
    svm_pred = predict(svm_model, data.frame(days = X)),
    lr_pred = predict(lr_model, data.frame(days = X))
  )

  ggplot(df, aes(x = days)) +
    geom_point(aes(y = actual), color = "black", size = 2, alpha = 0.7) +
    geom_line(aes(y = svm_pred), color = "red", linetype = "dashed", size = 1.2) +
    geom_line(aes(y = lr_pred), color = "blue", linetype = "solid", size = 1.2) +
    labs(
      title = "COVID-19 India: SVM vs Linear Regression",
      x = "Days",
      y = "Confirmed Cases"
    ) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5)) +
    scale_y_continuous(labels = scales::comma)
}