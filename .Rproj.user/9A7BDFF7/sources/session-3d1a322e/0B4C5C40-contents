# plotting_functions.R
# Visualization functions for RIPTA lateness
# ------------------------------------------

library(tidyverse)

# 1) Bar plot: lateness rate by route
plot_late_by_route <- function(df) {
  rates <- late_rate_by_route(df)
  
  ggplot(rates, aes(x = reorder(RouteId, pct_late), y = pct_late)) +
    geom_col() +
    coord_flip() +
    labs(
      title = "Lateness Rate by Route",
      x = "Route",
      y = "Percent Late"
    ) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1))
}

# 2) Line plot: lateness rate by hour of day
plot_late_by_hour <- function(df) {
  rates <- late_rate_by_hour(df)
  
  ggplot(rates, aes(x = Hour, y = pct_late, group = 1)) +
    geom_line() +
    geom_point() +
    labs(
      title = "Lateness Rate by Hour of Day",
      x = "Hour of Day",
      y = "Percent Late"
    ) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1))
}

# 3) Heatmap: lateness by weekday and hour
plot_weekday_heatmap <- function(df) {
  summary <- df %>%
    group_by(Weekday, Hour) %>%
    summarise(
      pct_late = mean(Late, na.rm = TRUE),
      .groups = "drop"
    )
  
  ggplot(summary, aes(x = Hour, y = Weekday, fill = pct_late)) +
    geom_tile() +
    labs(
      title = "Heatmap of Lateness by Weekday and Hour",
      x = "Hour of Day",
      y = "Weekday",
      fill = "Percent Late"
    ) +
    scale_fill_continuous(labels = scales::percent_format(accuracy = 1))
}

# 4) Histogram: distribution of delay (Deviation)
plot_delay_distribution <- function(df) {
  ggplot(df, aes(x = Deviation)) +
    geom_histogram(binwidth = 1, boundary = 0, closed = "left") +
    labs(
      title = "Distribution of Delay (Deviation)",
      x = "Delay in Minutes (early - / late +)",
      y = "Number of Stops"
    )
}