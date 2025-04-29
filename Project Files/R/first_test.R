# Load required package
library(ggplot2)

# 1. Define lambda(t): expected number of new cases on day t
lambda_t <- function(t, base_rate = 5, growth_rate = 0.2) {
  return(base_rate * (1 + growth_rate) ^ t)
}

# 2. Example: probability of exactly k new cases on day t
t <- 5         # Day 5
k <- 7         # Target number of cases
lambda <- lambda_t(t)

prob_k_cases <- dpois(k, lambda)
cat(sprintf("P(%d new cases on day %d) = %.4f\n", k, t, prob_k_cases))

# 3. Plot lambda(t) over 30 days
days <- 0:30
lambda_values <- lambda_t(days)

lambda_df <- data.frame(Day = days, Lambda = lambda_values)

ggplot(lambda_df, aes(x = Day, y = Lambda)) +
  geom_line(color = "blue", size = 1.2) +
  labs(title = "Expected New Cases Over Time (Lambda)",
       x = "Day",
       y = "Expected New Cases (λ)") +
  theme_minimal()

# 4. Simulate new cases for each day (Poisson random numbers)
set.seed(42)
sim_cases <- rpois(length(days), lambda_values)

sim_df <- data.frame(Day = days, SimulatedCases = sim_cases)

ggplot(sim_df, aes(x = Day, y = SimulatedCases)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Simulated Daily New Infections",
       x = "Day",
       y = "Number of Cases") +
  theme_minimal()

# Set working directory to where your script is
setwd("D:/Disease-Outbreak-Estimation-AP-S/Project Files")

# Ensure output folder exists
if (!dir.exists("../Project Pictures")) {
  dir.create("../Project Pictures")
}

# Define output path
output_path <- "../Project Pictures/my_plot.png"

# Save plot
png(filename = output_path, width = 800, height = 600)
plot(1:10, main = "Working Plot")
dev.off()