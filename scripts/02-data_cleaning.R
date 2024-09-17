#### Preamble ####
# Purpose: Cleans the raw neighborhood data to prepare it for analysis. 
# Author: Lexi Knight
# Date: 17 September 2025
# Contact: lexi.knight@mail.utoronto.ca
# License: MIT
# Pre-requisites: follow 01-download_data.R in scripts folder in order to access raw data

#### Workspace setup ####
# install packages
# install.packages("readr")
# install.packages("arrow")

# load libraries 
library(tidyverse)
library(readr)
library(arrow)

#### Clean data ####

# Check if the directory exists
dir.exists("data/raw_data")

# read the csv file 
raw_data <- read_csv("data/raw_data/neighborhood_raw_data.csv")

# select columns of interest - neighborhoods
cleaned_data <- raw_data |>
  select("rosedale-moore_park", "downtown_yonge_east")

# select rows of interest - demographics
cleaned_data <- raw_data |>
  select("total_visible_minority_population", "south_asian", "chinese", "black", "filipiono", "arab", "latin_american", "southeast_asian", "west_asain", "korean", "japanese", "multiple_visible_minorities", "not_a_visible_minority", "Average_total_income_in_2020_among_recipients_($)", "children", "in_a_two-parent_family", "in_a_one-parent_family", "total-knowledge_of_official_languages_for_the_population_in_private_households-25%_sample_data", "english_only", "french_only", "english_and_french", "neither_english_or_french")

# view entire dataset
print(cleaned_data, n = nrow(cleaned_data))



#### Save data ####
write_csv(cleaned_data, "inputs/data/analysis_data/neighborhood_analysis_data.csv")
