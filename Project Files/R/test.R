# Load data
data <- read.csv("Datasets/india_data_1.csv")
data <- na.omit(data)  # Remove missing values

# Convert dates to actual Date format
data$dates <- as.Date(data$dates, format = "%d-%b")

# Estimate Poisson parameter (λ)
lambda <- mean(data$daily_positive_cases)

# Simulate test counts (assumed: positive + noise)
set.seed(42)
data$daily_tests <- data$daily_positive_cases + rpois(nrow(data), lambda = 1000)

# Estimate Binomial probability
p_hat <- mean(data$daily_positive_cases / data$daily_tests)

# Generate predictions
poisson_pred <- rpois(n = nrow(data), lambda = lambda)
binom_pred <- rbinom(n = nrow(data), size = data$daily_tests, prob = p_hat)

# Plot predictions vs actual
plot(data$daily_positive_cases, type = "l", col = "black", lwd = 2,
     main = "COVID-19 Daily Cases: Actual vs Poisson & Binomial Predictions",
     ylab = "Daily Cases", xlab = "Day",
     ylim = range(c(data$daily_positive_cases, poisson_pred, binom_pred)))
lines(poisson_pred, col = "red", lwd = 2)
lines(binom_pred, col = "blue", lwd = 2)
legend("topright", legend = c("Actual", "Poisson", "Binomial"),
       col = c("black", "red", "blue"), lty = 1, lwd = 2)

# Mean Absolute Errors
cat("Poisson MAE:", mean(abs(data$daily_positive_cases - poisson_pred)), "\n")
cat("Binomial MAE:", mean(abs(data$daily_positive_cases - binom_pred)), "\n")

# Forecast next 7 days
future_poisson <- rpois(7, lambda)
future_binom <- rbinom(7, size = round(mean(data$daily_tests)), prob = p_hat)
cat("7-day Poisson Forecast:", future_poisson, "\n")
cat("7-day Binomial Forecast:", future_binom, "\n")

# Set working directory to where your script is
setwd("D:/Disease-Outbreak-Estimation-AP-S/Project Files")

# Ensure output folder exists
if (!dir.exists("../Project Pictures")) {
  dir.create("../Project Pictures")
}

# Define output path
output_path <- "../Project Pictures/first_good_plot.png"

# Save plot
png(filename = output_path, width = 800, height = 600)
plot(1:10, main = "Working Plot")
dev.off()