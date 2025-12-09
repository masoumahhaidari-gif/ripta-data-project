# plotting_functions.R
# --------------------
# Plots for RIPTA lateness patterns

library(dplyr)
library(ggplot2)

# 1) Distribution of delays (in minutes)
plot_delay_distribution <- function(df) {
  ggplot(df, aes(x = Delay.Sec / 60)) +
    geom_histogram(bins = 50, fill = "gray30") +
    xlim(-30, 60) +  # keep typical delays; remove extreme outliers
    scale_y_continuous(labels = scales::comma) +  # remove scientific notation
    labs(
      x = "Delay (minutes)",
      y = "Number of stops",
      title = "Distribution of RIPTA bus delays (cleaned)"
    )
}

# 2) Lateness rate by route (for routes with enough data)
#    -> tweaked so labels are less cramped and easier to read
plot_late_by_route <- function(df, min_n = 500) {
  route_stats <- df %>%
    group_by(Route) %>%
    summarise(
      n        = n(),
      late_rate = mean(Late, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    filter(n >= min_n) %>%
    arrange(late_rate)   # order routes from lowest to highest late rate
  
  ggplot(route_stats,
         aes(x = late_rate,
             y = reorder(Route, late_rate))) +
    geom_col(fill = "grey40") +
    labs(
      x = "Proportion late",
      y = "Route",
      title = paste0(
        "Lateness rate by route (routes with at least ",
        min_n, " stops)"
      )
    ) +
    scale_y_discrete(expand = expansion(mult = c(0.02, 0.02))) + # a bit of vertical spacing
    theme_minimal(base_size = 14) +
    theme(
      axis.text.y  = element_text(size = 7),      # smaller route labels
      plot.title   = element_text(size = 16, face = "bold"),
      axis.title   = element_text(size = 13)
    )
}

# 3) Lateness rate by hour of day
plot_late_by_hour <- function(df) {
  df %>%
    group_by(Hour) %>%
    summarise(late_rate = mean(Late, na.rm = TRUE)) %>%
    ggplot(aes(x = Hour, y = late_rate)) +
    geom_line() +
    geom_point() +
    scale_x_continuous(breaks = 0:23) +
    labs(
      x = "Hour of day",
      y = "Proportion late",
      title = "Lateness rate by hour of day"
    )
}

# 4) Heatmap: lateness by weekday & hour
plot_weekday_heatmap <- function(df) {
  df %>%
    group_by(Weekday, Hour) %>%
    summarise(late_rate = mean(Late, na.rm = TRUE), .groups = "drop") %>%
    ggplot(aes(x = Hour, y = Weekday, fill = late_rate)) +
    geom_tile() +
    scale_x_continuous(breaks = 0:23) +
    labs(
      x = "Hour of day",
      y = "Weekday",
      fill = "Late rate",
      title = "Lateness rate by hour and weekday"
    )
}

# 5) Bar chart: Effect of 3-Minute Schedule Buffer on Lateness Rate
plot_buffer_effect <- function(original_rate, new_rate) {
  df <- data.frame(
    Scenario = c("Original", "With 3-Min Buffer"),
    LatenessRate = c(original_rate, new_rate)
  )
  
  ggplot(df, aes(x = Scenario, y = LatenessRate, fill = Scenario)) +
    geom_col(width = 0.6) +
    scale_y_continuous(labels = scales::percent_format()) +
    labs(
      title = "Effect of 3-Minute Schedule Buffer on Lateness Rate",
      x = "", y = "Lateness Rate"
    ) +
    theme_minimal(base_size = 12) +
    theme(
      plot.title = element_text(size = 14, face = "bold"),
      axis.text = element_text(size = 10),
      legend.position = "none"
    )
}


