# Purpose: Analyze missing data in penguins dataset
# Author: Shivank Goel
# Date: 3rd March 2024
# Contact: shivankg.goel@mail.utoronto.ca 
# License: MIT

library(tidyverse)
library(dplyr)
library(janitor)
library(palmerpenguins)

# Read the penguins data
penguins_data_csv <- read_csv("inputs/data/penguins_data.csv")

# Additionally, load and clean the data again from the palmerpenguins package
penguins_data =  clean_names(penguins_data) 

# Identifying and handling outliers
# Assuming bill length less than 30mm and greater than 60mm as outliers for this example
penguins_data <- penguins_data %>% 
  filter(bill_length_mm > 30, bill_length_mm < 60)

# Checking for duplicate rows and removing them
penguins_data <- penguins_data %>% 
  distinct()

# Checking for any illogical values or errors
# Ensuring sex is either male, female, or NA
penguins_data <- penguins_data %>%
  mutate(sex = case_when(
    sex %in% c("male", "female") ~ sex,
    TRUE ~ NA_character_
  ))



#### Save data ####
write_csv(penguins_data, "outputs/data/cleaned_penguins_data.csv")

# Displaying the first few rows of the cleaned data
head(penguins_data)