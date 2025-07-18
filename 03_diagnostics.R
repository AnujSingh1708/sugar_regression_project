# Load required packages
library(tidyverse)
library(ggplot2)
library(broom)

# Load model and data
model_sugar <- readRDS("../scripts/sugar_model.rds")
sugar_data <- read_csv("../data/sugar_data_cleaned.csv")

# --- 1. Coefficient Plot ---
coef_data <- tidy(model_sugar, conf.int = TRUE)

ggplot(coef_data, aes(x = term, y = estimate)) +
  geom_point(color = "#2c7fb8", size = 3) +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2, color = "#2c7fb8") +
  labs(title = "Coefficient Plot for High Sugar Model", x = "Predictor", y = "Estimate") +
  theme_minimal()

ggsave("../plots/Coefficient plot for blood sugar.png")

# --- 2. Actual vs Fitted Plot ---
sugar_data$fitted <- fitted(model_sugar)

ggplot(sugar_data, aes(x = fitted, y = sugar_high)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred") +
  labs(title = "Actual vs Fitted: Sugar Model", x = "Fitted Values", y = "Actual Values") +
  theme_minimal()

ggsave("../plots/Actual vs fitted plot (sugar).png")

# --- 3. Diagnostic Plots ---
png("../plots/Diagnostic plots (sugar).png", width = 800, height = 800)
par(mfrow = c(2, 2))
plot(model_sugar)
dev.off()
