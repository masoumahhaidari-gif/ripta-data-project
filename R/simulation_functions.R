# simulation_functions.R
# ----------------------
# Simulate schedule buffers and effects on lateness

library(dplyr)
library(lubridate)

# Simulate adding a buffer (in minutes) to Scheduled.Time
simulate_buffer <- function(df, buffer = 3) {
  
  df %>%
    mutate(
      # add buffer to scheduled time
      Scheduled.Time_buffered = Scheduled.Time + minutes(buffer),
      
      # recompute delay based on buffered schedule (in seconds)
      Delay_buffered_sec = as.numeric(
        difftime(Actual.Arrival.Time,
                 Scheduled.Time_buffered,
                 units = "secs")
      ),
      
      # new lateness indicator using same 5-minute rule (> 300 sec)
      Late_sim = if_else(Delay_buffered_sec > 5 * 60, 1L, 0L)
    )
}
