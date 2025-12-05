options(scipen = 999)
source("R/data_load.R")
source("R/feature_engineering.R")
source("R/summary_functions.R")
source("R/plotting_functions.R")
source("R/model_functions.R")
source("R/simulation_functions.R")

otp_raw   <- load_otp_data("data/otp_simulated.csv")
otp_clean <- clean_otp_data(otp_raw)

# 3. Feature engineering
otp_feat <- create_features(otp_clean)

# 4. Fit logistic regression model
late_model <- fit_late_model(otp_feat)

# look at model results
summary(late_model)

# add predicted probabilities back to the data
otp_feat <- add_predicted_prob(otp_feat, late_model)


# quick check
dplyr::glimpse(otp_feat)
mean(otp_feat$Late)   # overall lateness rate

# 5. Summary statistics / EDA -------------------------------------------

overall_late <- late_rate_overall(otp_feat)
by_route     <- late_rate_by_route(otp_feat)
by_hour      <- late_rate_by_hour(otp_feat)
by_weekday   <- late_rate_by_weekday(otp_feat)

overall_late     # overall lateness rate
head(by_route)   # top routes by lateness
by_hour          # lateness by hour
by_weekday       # lateness by weekday


# 6. Plots --------------------------------------------------------------

p_delay   <- plot_delay_distribution(otp_feat)
p_route   <- plot_late_by_route(otp_feat)
p_hour    <- plot_late_by_hour(otp_feat)
p_heatmap <- plot_weekday_heatmap(otp_feat)

# Show the plots
p_delay
p_route
p_hour
p_heatmap

ggsave("figures/delay_distribution.png", p_delay,   width = 7, height = 5)
ggsave("figures/lateness_by_route.png",  p_route,   width = 7, height = 5)
ggsave("figures/lateness_by_hour.png",   p_hour,    width = 7, height = 5)
ggsave("figures/lateness_heatmap.png",   p_heatmap, width = 7, height = 5)

p_route <- plot_late_by_route(otp_feat)
p_route

# 7. Simulation -------------------------------------------------------------

sim_3min <- simulate_buffer(otp_feat, buffer = 3)

# Compare original vs simulated
mean(otp_feat$Late)        # original lateness rate
mean(sim_3min$Late_sim)    # new lateness rate with 3 min buffer




