# Load necessary libraries
library(ggplot2)  # for plotting
library(MASS)  # for truehist and other tools

# 1. Sample Data Generation
set.seed(42)
days <- 1:30  # Day of the outbreak
mobility_factor <- runif(30, min = 0, max = 1)  # Random mobility factor
base_rate <- 5  # Base rate of new infections
growth_rate <- 0.2  # Growth rate

# Generate lambda(t) based on exponential growth
lambda <- base_rate * (1 + growth_rate) ^ days

# Simulate daily new cases using Poisson distribution
new_cases <- rpois(30, lambda)

# Combine into a dataframe
data <- data.frame(Day = days, Mobility = mobility_factor, NewCases = new_cases)

# 2. Linear Regression Model (Predict new cases using 'Day' and 'Mobility')
lm_model <- lm(NewCases ~ Day + Mobility, data = data)

# Predict new cases using linear regression
data$PredictedCases_LM <- predict(lm_model, newdata = data)

# Summary of the linear regression model
cat("\nLinear Regression Model Summary:\n")
summary(lm_model)

# Plot the Linear Regression Predictions
ggplot(data, aes(x = Day, y = NewCases)) +
  geom_point(color = 'blue') +
  geom_line(aes(y = PredictedCases_LM), color = 'red') +
  labs(title = "Linear Regression: New Cases vs Day",
       x = "Day", y = "New Cases") +
  theme_minimal()

# 3. Poisson Distribution: Probability of exactly 7 cases on Day 5
t <- 5
k <- 7
lambda_t <- base_rate * (1 + growth_rate) ^ t  # Lambda for Day 5
poisson_prob <- dpois(k, lambda_t)
cat(sprintf("\nPoisson Probability of exactly 7 new cases on Day %d: %.4f\n", t, poisson_prob))

# 4. Simulate new infections using Poisson for 30 days
sim_cases <- rpois(30, lambda)

# Plot simulated infections
sim_df <- data.frame(Day = days, SimulatedCases = sim_cases)

ggplot(sim_df, aes(x = Day, y = SimulatedCases)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Simulated Daily New Infections Using Poisson",
       x = "Day", y = "Simulated Cases") +
  theme_minimal()

# Set working directory to where your script is
setwd("D:/Disease-Outbreak-Estimation-AP-S/Project Files")

# Ensure output folder exists
if (!dir.exists("../Project Pictures")) {
  dir.create("../Project Pictures")
}

# Define output path
output_path <- "../Project Pictures/first.png"

# Save plot
png(filename = output_path, width = 800, height = 600)
plot(1:10, main = "Working Plot")
dev.off()