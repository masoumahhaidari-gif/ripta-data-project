# model_functions.R
# Fits a logistic regression model for bus lateness
# -------------------------------------------------

library(tidyverse)
library(broom)

# Fit logistic regression:
# Late (0/1) ~ RouteId + Hour + Weekday
fit_late_model <- function(df) {
  
  df_model <- df %>%
    filter(!is.na(Late),
           !is.na(RouteId),
           !is.na(Hour),
           !is.na(Weekday)) %>%
    mutate(
      RouteId = as.factor(RouteId),
      Weekday = as.factor(Weekday)
    )
  
  model <- glm(
    Late ~ RouteId + Hour + Weekday,
    data   = df_model,
    family = binomial()
  )
  
  return(model)
}

# Tidy summary of coefficients
summarise_late_model <- function(model) {
  broom::tidy(model)
}

# Add predicted lateness probability
add_predicted_prob <- function(df, model) {
  df %>%
    mutate(
      PredLateProb = predict(model, newdata = df, type = "response")
    )
}
