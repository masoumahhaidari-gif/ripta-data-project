# summary_functions.R
# EDA summaries for RIPTA lateness
# ---------------------------------

library(tidyverse)

# Overall lateness: one-row summary
late_rate_overall <- function(df) {
  df %>%
    summarise(
      n_total  = n(),
      n_late   = sum(Late, na.rm = TRUE),
      pct_late = n_late / n_total
    )
}

# Lateness rate by RouteId
late_rate_by_route <- function(df) {
  df %>%
    group_by(RouteId) %>%
    summarise(
      n_total  = n(),
      n_late   = sum(Late, na.rm = TRUE),
      pct_late = n_late / n_total,
      .groups  = "drop"
    ) %>%
    arrange(desc(pct_late))
}

# Lateness rate by hour of day
late_rate_by_hour <- function(df) {
  df %>%
    group_by(Hour) %>%
    summarise(
      n_total  = n(),
      n_late   = sum(Late, na.rm = TRUE),
      pct_late = n_late / n_total,
      .groups  = "drop"
    ) %>%
    arrange(Hour)
}

# Lateness rate by weekday
late_rate_by_weekday <- function(df) {
  df %>%
    group_by(Weekday) %>%
    summarise(
      n_total  = n(),
      n_late   = sum(Late, na.rm = TRUE),
      pct_late = n_late / n_total,
      .groups  = "drop"
    ) %>%
    arrange(Weekday)
}