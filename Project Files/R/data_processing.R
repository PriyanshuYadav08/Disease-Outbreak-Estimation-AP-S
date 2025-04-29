library(dplyr)
library(caret)

load_data <- function() {
  df <- read.csv("../Datasets/time_series_covid-19_confirmed.csv", check.names = FALSE)

  # Filter for India
  india <- df %>% filter(`Country/Region` == "India")

  # Drop non-date columns
  india <- india[, !(names(india) %in% c("Province/State", "Country/Region", "Lat", "Long"))]

  # Sum across provinces
  cases <- colSums(india)

  # Create DataFrame
  dates <- names(cases)
  df_cases <- data.frame(
    date = as.Date(dates, format = "%m/%d/%y"),
    cases = as.numeric(cases),
    days = 1:length(cases)
  )

  # Train-test split (80/20)
  set.seed(42)
  splitIndex <- createDataPartition(df_cases$cases, p = 0.8, list = FALSE)
  train <- df_cases[splitIndex, ]
  test <- df_cases[-splitIndex, ]

  list(
    X_train = train[, "days", drop = FALSE],
    y_train = train$cases,
    X_test = test[, "days", drop = FALSE],
    y_test = test$cases
  )
}