# feature_engineering.R
# ---------------------
# Create features for lateness prediction using OTP data

library(dplyr)
library(lubridate)

# 1) Create binary Late variable
#    Late = 1 if delay > 5 minutes (300 seconds), else 0
create_late_variable <- function(df, threshold_sec = 300) {
  df %>%
    mutate(
      Late = if_else(Delay.Sec > threshold_sec, 1L, 0L)
    )
}

# 2) Add time-based features: Hour, Weekday, TimeOfDay
add_time_features <- function(df) {
  df %>%
    mutate(
      # Use actual arrival time as the event time
      Hour    = hour(Actual.Arrival.Time),
      Weekday = wday(Date, label = TRUE, abbr = TRUE),
      TimeOfDay = case_when(
        Hour < 6  ~ "Night",
        Hour < 12 ~ "Morning",
        Hour < 17 ~ "Afternoon",
        TRUE      ~ "Evening"
      )
    ) %>%
    mutate(
      Route    = as.factor(Route),
      Trip     = as.factor(Trip),
      Stop     = as.factor(Stop),
      TimeOfDay = factor(TimeOfDay,
                         levels = c("Night", "Morning", "Afternoon", "Evening"))
    )
}

# 3) Master feature-creation pipeline
create_features <- function(df) {
  df %>%
    create_late_variable() %>%
    add_time_features()
}
