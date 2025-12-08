# model_functions.R
# ------------------
# Logistic regression model for bus lateness

library(dplyr)

# 1) Fit logistic regression model
fit_late_model <- function(df) {
  glm(
    Late ~ Route + Hour + Weekday + TimeOfDay,
    data   = df,
    family = binomial()
  )
}

# 2) Add predicted probabilities of being late
add_predicted_prob <- function(df, model) {
  df %>%
    mutate(
      p_late = predict(model, type = "response")
    )
}

# 3) Summarise model in a tidy way (optional but handy)
summarise_late_model <- function(model) {
  broom::tidy(model)
}
