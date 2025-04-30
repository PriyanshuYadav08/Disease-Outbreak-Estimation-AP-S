# Load libraries
library(MASS)

# Load the data
data <- read.csv("Datasets/india_data_1.csv")
data <- na.omit(data)

# Convert dates (format like "01-Jan" assumed)
data$dates <- as.Date(data$dates, format = "%d-%b")

# Create a time trend variable
data$day_number <- 1:nrow(data)

# Fit Negative Binomial regression
nb_model <- glm.nb(daily_positive_cases ~ day_number, data = data)

# Predict values for the current data
nb_pred <- predict(nb_model, type = "response")

# Forecast for the next 7 days
future_days <- data.frame(day_number = (nrow(data) + 1):(nrow(data) + 7))
future_pred <- predict(nb_model, newdata = future_days, type = "response")

# Print forecast
cat("7-day Negative Binomial Forecast:\n", round(future_pred), "\n")

# Plot actual vs predicted
plot(data$daily_positive_cases, type = "l", col = "black", lwd = 2,
     main = "COVID-19 Daily Cases: Actual vs NB Model",
     ylab = "Daily Positive Cases", xlab = "Day")
lines(nb_pred, col = "green", lwd = 2)
legend("topright", legend = c("Actual", "Negative Binomial Prediction"),
       col = c("black", "green"), lty = 1, lwd = 2)

# Save plot
setwd("D:/Disease-Outbreak-Estimation-AP-S/Project Files")
if (!dir.exists("../Project Pictures")) {
    dir.create("../Project Pictures")
}
png("../Project Pictures/NB_Model_Plot.png", width = 1600, height = 1600)
plot(data$daily_positive_cases, type = "l", col = "black", lwd = 2,
     main = "COVID-19 Daily Cases: Actual vs NB Model",
     ylab = "Daily Positive Cases", xlab = "Day")
lines(nb_pred, col = "green", lwd = 2)
legend("topright", legend = c("Actual", "Negative Binomial Prediction"),
       col = c("black", "green"), lty = 1, lwd = 2)
dev.off()