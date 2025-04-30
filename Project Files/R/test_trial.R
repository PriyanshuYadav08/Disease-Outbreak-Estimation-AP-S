# Load data
data <- read.csv("Datasets/india_data_1.csv")
data <- na.omit(data)

# Convert dates to Date type
data$dates <- as.Date(data$dates, format = "%d-%b")

# Poisson parameter (λ)
lambda <- mean(data$daily_positive_cases)

# Simulated daily tests
set.seed(42)
data$daily_tests <- data$daily_positive_cases + rpois(nrow(data), lambda = 1000)

# Estimate Binomial probability
p_hat <- mean(data$daily_positive_cases / data$daily_tests)

# Generate predictions
poisson_pred <- rpois(nrow(data), lambda = lambda)
binom_pred <- rbinom(nrow(data), size = data$daily_tests, prob = p_hat)

# Set working directory
setwd("D:/Disease-Outbreak-Estimation-AP-S/Project Files")

# Create output folder if needed
if (!dir.exists("../Project Pictures")) {
    dir.create("../Project Pictures")
}

# Save actual vs predicted plot
output_path <- "../Project Pictures/Tested_Graph.png"
png(filename = output_path, width = 1600, height = 1600)

# Plot with legend
plot(data$daily_positive_cases,
    type = "l", col = "black", lwd = 2,
    main = "COVID-19 Daily Cases: Actual vs Poisson & Binomial Predictions",
    ylab = "Daily Cases", xlab = "Day",
    ylim = range(c(data$daily_positive_cases, poisson_pred, binom_pred))
)
lines(poisson_pred, col = "red", lwd = 2)
lines(binom_pred, col = "blue", lwd = 2)
legend("topright",
    legend = c("Actual", "Poisson", "Binomial"),
    col = c("black", "red", "blue"), lty = 1, lwd = 2
)

dev.off()

# Print errors and forecasts
cat("Poisson MAE:", mean(abs(data$daily_positive_cases - poisson_pred)), "\n")
cat("Binomial MAE:", mean(abs(data$daily_positive_cases - binom_pred)), "\n")

future_poisson <- rpois(7, lambda)
future_binom <- rbinom(7, size = round(mean(data$daily_tests)), prob = p_hat)
cat("7-day Poisson Forecast:", future_poisson, "\n")
cat("7-day Binomial Forecast:", future_binom, "\n")
