# feature_engineering.R
# Create Late variable and time-based predictors
# ----------------------------------------------

library(tidyverse)
library(lubridate)

# 1) Create Late = 1 if IncidentName == "LATE", else 0
create_late_variable <- function(df) {
  df %>%
    mutate(
      Late = if_else(IncidentName == "LATE", 1L, 0L)
    )
}

# 2) Add hour of day, weekday, and time-of-day category
add_time_features <- function(df) {
  df %>%
    mutate(
      Hour    = hour(ScheduleTime),
      Weekday = wday(ScheduleTime, label = TRUE, abbr = TRUE),
      time_of_day = case_when(
        Hour >= 5  & Hour < 12 ~ "morning",
        Hour >= 12 & Hour < 17 ~ "afternoon",
        Hour >= 17 & Hour < 22 ~ "evening",
        TRUE                   ~ "night"
      ),
      time_of_day = factor(time_of_day)
    )
}

# 3) Make sure key IDs are factors (standardize identifiers)
standardize_ids <- function(df) {
  df %>%
    mutate(
      RouteId = as.factor(RouteId),
      TripId  = as.factor(TripId),
      RunId   = as.factor(RunId),
      DriverId = as.factor(DriverId)
    )
}

# 4) Full feature pipeline
create_features <- function(df) {
  df %>%
    create_late_variable() %>%
    add_time_features() %>%
    standardize_ids()
}

