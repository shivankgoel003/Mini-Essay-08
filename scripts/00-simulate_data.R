#### Preamble ####
# Purpose: Simulate a scenario for penguins dataset
# Author: Shivank Goel
# Date: 3rd March 2024
# Contact: shivankg.goel@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
# - Need to have installed the 'tidyverse' and 'dplyr' packages.

library(tidyverse)
library(dplyr)
library(palmerpenguins)

#### Simulate data ####
cleaned_penguins_data <- read_csv("outputs/data/cleaned_penguins_data.csv")

#### Simulate data ####
set.seed(123)  # Setting a seed for reproducibility

# Simulating based on cleaned data
# For example, let's simulate bill length and depth with added random noise
simulated_penguins_data <- cleaned_penguins_data %>%
  mutate(
    simulated_bill_length_mm = bill_length_mm + rnorm(n(), mean = 0, sd = 2),
    simulated_bill_depth_mm = bill_depth_mm + rnorm(n(), mean = 0, sd = 1)
  )

# Simulate missing data in bill_length_mm variable
# For example, let's randomly set 10% of bill_length_mm data to NA (missing)
missing_indices <- sample(1:nrow(cleaned_penguins_data), 0.1 * nrow(cleaned_penguins_data))
cleaned_penguins_data$bill_length_mm[missing_indices] <- NA


# Summary statistics for bill length for each species
summary_stats <- cleaned_penguins_data %>%
  group_by(species) %>%
  summarise(
    mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
    sd_bill_length = sd(bill_length_mm, na.rm = TRUE)
  )

# Simulating bill lengths for each species based on the summary statistics
simulate_bill_length <- function(species_name, n) {
  species_stats <- filter(summary_stats, species == species_name)
  rnorm(n, mean = species_stats$mean_bill_length, sd = species_stats$sd_bill_length)
}

# Number of simulations for each species
n_simulations <- 100

# Generating simulated data
simulated_penguins_data <- tibble(
  species = rep(c("Adelie", "Chinstrap", "Gentoo"), each = n_simulations),
  bill_length_mm = c(
    simulate_bill_length("Adelie", n_simulations),
    simulate_bill_length("Chinstrap", n_simulations),
    simulate_bill_length("Gentoo", n_simulations)
  )
)

write_csv(simulated_penguins_data, "outputs/data/simulated_penguins_data.csv")