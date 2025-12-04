# feature_engineering.R
# Creates key variables used for modeling OTP delays
# -----------------------------------------------------

library(tidyverse)
library(lubridate)

# 1) Create delay variable (in minutes)
add_delay_features <- function(df) {
  df %>%
    mutate(
      DelayMinutes = as.numeric(difftime(IncidentDateTime, ScheduleTime, units = "mins")),
      IsLate       = DelayMinutes > 0
    )
}

# 2) Extract useful time features (hour, weekday)
add_time_features <- function(df) {
  df %>%
    mutate(
      Hour    = hour(ScheduleTime),
      Weekday = wday(ScheduleTime, label = TRUE)
    )
}

# 3) Full feature pipeline
create_features <- function(df) {
  df %>%
    add_delay_features() %>%
    add_time_features()
}
