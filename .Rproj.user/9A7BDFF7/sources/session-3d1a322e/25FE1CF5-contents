# simulation_functions.R
# Simulate schedule buffers and effects on lateness
# --------------------------------------------------

library(tidyverse)
library(lubridate)

# Simulate adding a buffer (in minutes) to ScheduleTime
simulate_buffer <- function(df, buffer = 3) {
  
  df_sim <- df %>%
    mutate(
      # add buffer to scheduled time
      ScheduleTime_buffered = ScheduleTime + minutes(buffer),
      
      # recalculate deviation based on buffered schedule
      Deviation_buffered = as.numeric(
        difftime(IncidentDateTime, ScheduleTime_buffered, units = "mins")
      ),
      
      # new lateness indicator using RIPTA rule: late = > 5 minutes
      Late_buffered = if_else(Deviation_buffered > 5, 1L, 0L)
    )
  
  original_late_rate <- mean(df$Late, na.rm = TRUE)
  new_late_rate      <- mean(df_sim$Late_buffered, na.rm = TRUE)
  
  tibble(
    buffer_minutes       = buffer,
    original_late_rate   = original_late_rate,
    new_late_rate        = new_late_rate,
    improvement_absolute = original_late_rate - new_late_rate
  )
}

# Simulate multiple buffer sizes, e.g. 0, 1, 2, 3, 4, 5 minutes
simulate_multiple_buffers <- function(df, buffers = c(0, 1, 2, 3, 4, 5)) {
  map_dfr(buffers, ~ simulate_buffer(df, buffer = .x))
}