# Load required packages
library(tidyverse)
library(car)
library(MASS)

# Load cleaned data
sugar_data <- read_csv("../data/sugar_data_cleaned.csv")

# Prepare data
predictors <- sugar_data %>%
  select(underweight, overweight, tobacco, alcohol)
outcome <- sugar_data$sugar_high

sugar_df <- bind_cols(predictors, high_sugar = outcome)

# Build linear model
model_sugar <- lm(high_sugar ~ underweight + overweight + tobacco + alcohol, data = sugar_df)

# Model summary
summary(model_sugar)

# Check multicollinearity
vif(model_sugar)

# Stepwise regression
step_model_sugar <- stepAIC(model_sugar, direction = "both")
summary(step_model_sugar)

# Save model object
saveRDS(model_sugar, "../scripts/sugar_model.rds")
