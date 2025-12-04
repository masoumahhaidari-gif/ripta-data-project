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
      # convert times to proper datetime
      IncidentDateTime = ymd_hms(IncidentDateTime),
      ScheduleTime     = ymd_hms(ScheduleTime)
    ) %>%
    # drop rows with missing key info
    filter(
      !is.na(IncidentDateTime),
      !is.na(ScheduleTime),
      !is.na(IncidentName)
    )
}
