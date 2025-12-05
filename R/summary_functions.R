# summary_functions.R
# -------------------
# EDA summaries for RIPTA lateness

library(dplyr)

# Overall late rate
late_rate_overall <- function(df) {
  df %>%
    summarise(overall_late_rate = mean(Late, na.rm = TRUE))
}

# Late rate by route
late_rate_by_route <- function(df) {
  df %>%
    group_by(Route) %>%
    summarise(
      n        = n(),
      late_rate = mean(Late, na.rm = TRUE)
    ) %>%
    arrange(desc(late_rate))
}

# Late rate by hour of day
late_rate_by_hour <- function(df) {
  df %>%
    group_by(Hour) %>%
    summarise(
      n        = n(),
      late_rate = mean(Late, na.rm = TRUE)
    ) %>%
    arrange(Hour)
}

# Late rate by weekday
late_rate_by_weekday <- function(df) {
  df %>%
    group_by(Weekday) %>%
    summarise(
      n        = n(),
      late_rate = mean(Late, na.rm = TRUE)
    ) %>%
    arrange(Weekday)
}
