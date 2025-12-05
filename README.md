README — RIPTA Bus Lateness Project

Purpose:
This project analyzes RIPTA on-time performance and answers the question:
“What factors predict whether a bus arrives late, and how does lateness change if a 3-minute schedule buffer is added?”

The workflow includes data cleaning, feature engineering, a logistic regression model, visualizations, and a simulation of schedule changes.

Repository Structure:

main.R                     - Runs the full analysis pipeline

R/                         - Folder with all project functions
  data_load.R
  feature_engineering.R
  model_functions.R
  plotting_functions.R
  simulation_functions.R
  summary_functions.R

data/                      - Place your OTP dataset here (not included)
figures/                   - Output plots
README.md                  - Project documentation



Note: The OTP dataset is not included in this repository. Place the data file in a local /data folder before running the analysis.

How to Run the Project:

Open the RStudio project (.Rproj file).
Add your RIPTA OTP CSV to the /data folder.
Run the entire analysis with:
source("main.R")


This will Load and clean the OTP dataset. Create feature variables (hour, weekday, lateness). Fit the logistic regression model. Produce and save plots
Run the 3-minute buffer simulation and print updated lateness rates. All figures are saved automatically to the /figures folder.

Outputs:

Plots: delay distribution, lateness by route, lateness by hour, weekday–hour heatmap
Simulation: comparison of original vs. buffered lateness rate

Reproducibility:

This project uses modular R scripts, a single pipeline file, and GitHub version control to ensure transparency and reproducibility.

