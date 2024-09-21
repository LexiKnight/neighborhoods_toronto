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
# install.packages("dplyr")

# load libraries 
library(readr)
library(dplyr)

#### Clean data ####

# Read the csv file 
raw_data <- read_csv("inputs/data/raw_data/neighborhood_raw_data.csv")

# Trim any extra white spaces in column names
colnames(raw_data) <- trimws(colnames(raw_data))

# Select columns of interest (neighborhoods and row identifiers)
selected_neighborhoods <- c("Rosedale-Moore Park", "Downtown Yonge East")

# Manually specify the row indices of interest - I am doing this because there
# are multiple rows with the same names
visible_minority_categories <- c(1641:1655) # need move up by 1, was 42-56
income_categories <- c(93:105) #need move up by 1, was 94-106
education_categories <- c(1982, 1983, 1985:1987, 1989:1990, 1992:1996) # off by one (move all up by 1) should be 1983, 1984, 1986:1988, 1990-1991, 1993:1997
knowledge_of_official_language <- c(427:431) # should be 28-32. move up by 1

# Subset the data based on row indices and selected neighborhoods
visible_minority_data <- raw_data[visible_minority_categories, c("Neighbourhood Name", selected_neighborhoods)]
income_data <- raw_data[income_categories, c("Neighbourhood Name", selected_neighborhoods)]
education_data <- raw_data[education_categories, c("Neighbourhood Name", selected_neighborhoods)]
language_data <- raw_data[knowledge_of_official_language, c("Neighbourhood Name", selected_neighborhoods)]

# Combine all the subsets into one final dataset
final_analysis_data <- bind_rows(
  visible_minority_data,
  income_data,
  education_data,
  language_data
)

# Print the final analysis data
print(final_analysis_data)


#### Save data ####
write_csv(final_analysis_data, "inputs/data/analysis_data/neighborhood_analysis_data.csv")
