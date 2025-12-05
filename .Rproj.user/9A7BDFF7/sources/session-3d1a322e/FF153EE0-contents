# ------------------------------
# data_load.R
# Loads and cleans RIPTA OTP dataset
# ------------------------------

library(tidyverse)
library(lubridate)

# 1) Load OTP data from a csv file
load_otp_data <- function(path) {
  read_csv(path, show_col_types = FALSE)
}

# 2) Clean and format variables
clean_otp_data <- function(df) {
  df %>%
    mutate(
      # rename and parse times from the real column names
      IncidentDateTime = ymd_hms(`Actual.Arrival.Time`),
      ScheduleTime     = ymd_hms(`Scheduled.Time`),
      
      # convert delay from seconds to minutes so it matches our plan
      Deviation = Delay.Sec / 60
    ) %>%
    filter(
      !is.na(IncidentDateTime),
      !is.na(ScheduleTime)
    )
}

