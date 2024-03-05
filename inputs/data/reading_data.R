# Purpose: Analyze missing data in penguins dataset
# Author: Shivank Goel
# Date: 23rd February 2024
# Contact: shivankg.goel@mail.utoronto.ca 
# License: MIT

library(tidyverse)
library(dplyr)
library(palmerpenguins)

# Read the penguins data
penguins_data <- penguins %>%
  # Cleaning or any other required processing steps can be added here
  na.omit() # This line can be changed based on specific requirements

# Save the cleaned data (optional)
write_csv(penguins_data, "inputs/data/penguins_data.csv")

# Output the first few rows of the data
head(penguins_data)