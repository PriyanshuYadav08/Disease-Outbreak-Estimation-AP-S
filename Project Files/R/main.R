source("data_processing.r")
source("model.R")
source("visualize.R")

main <- function() {
  tryCatch({
    # Load data
    data <- load_data()
    if (is.null(data$X_train) || is.null(data$y_train) || is.null(data$X_test) || is.null(data$y_test)) {
      stop("Error: Missing data from load_data function.")
    }
    
    # Train models
    models <- train_models(data$X_train, data$y_train)
    if (is.null(models$svm) || is.null(models$lr)) {
      stop("Error: Missing models from train_models function.")
    }
    svm_model <- models$svm
    lr_model <- models$lr
    
    # Plot predictions
    plot_predictions(svm_model, lr_model, data$X_test, data$y_test)
    
    # Predict next 10 days
    last_day <- max(data$X_train$days)
    if (!is.numeric(last_day)) {
      stop("Error: X_train$days must be numeric.")
    }
    future_days <- data.frame(days = (last_day + 1):(last_day + 10))
    
    future_svm <- predict(svm_model, future_days)
    future_lr <- predict(lr_model, future_days)
    if (!is.numeric(future_svm) || !is.numeric(future_lr)) {
      stop("Error: Predictions must be numeric.")
    }
    
    # Output predictions
    cat("\nPredictions for next 10 days (SVM):\n")
    for (i in 1:10) {
      cat(sprintf("Day %d: %d cases (SVM)\n", future_days$days[i], round(future_svm[i])))
    }
    
    cat("\nPredictions for next 10 days (Linear Regression):\n")
    for (i in 1:10) {
      cat(sprintf("Day %d: %d cases (LR)\n", future_days$days[i], round(future_lr[i])))
    }
  }, error = function(e) {
    cat("An error occurred: ", e$message, "\n")
  })
}

main()