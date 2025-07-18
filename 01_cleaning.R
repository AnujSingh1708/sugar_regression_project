# Load required packages
library(tidyverse)
library(haven)
library(skimr)
library(janitor)

# Set working directory to your project data folder
setwd("E:/Projects/NFHS5_Analysis/data/Men's NCD risk")

# Load raw data
datafile <- read_csv("datafile.csv")

# Clean column names
datafile <- datafile %>% clean_names()

# Select relevant columns for sugar model
men_ncd <- datafile %>%
  select(
    state = states_u_ts,
    area,
    underweight = men_age_15_49_years_whose_body_mass_index_bmi_is_below_normal_bmi_18_5_kg_m2_percent,
    overweight = men_age_15_49_years_who_are_overweight_or_obese_bmi_25_0_kg_m2_percent,
    sugar_high = men_age_15_years_and_above_wih_high_or_very_high_140_mg_dl_blood_sugar_level_or_taking_medicine_to_control_blood_sugar_level23_percent,
    tobacco = men_age_15_years_and_above_who_use_any_kind_of_tobacco_percent,
    alcohol = men_age_15_years_and_above_who_consume_alcohol_percent
  )

# Convert non-categorical columns to numeric
men_ncd <- men_ncd %>%
  mutate(across(-c(state, area), ~ as.numeric(str_trim(.))))

# Keep only 'Total' rows
men_ncd_total <- men_ncd %>%
  filter(area == "Total") %>%
  select(-area)

# Export cleaned data
write_csv(men_ncd_total, "../data/sugar_data_cleaned.csv")
