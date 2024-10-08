#### Preamble ####
# Purpose: Cleans the raw neighborhood data to prepare it for analysis. 
# Author: Lexi Knight
# Date: 17 September 2025
# Contact: lexi.knight@mail.utoronto.ca
# License: MIT
# Pre-requisites: complete 01-download_data.R in scripts folder in order to access raw data.

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

# Manually specify the row indices of interest - due to multiple rows with the same names
visible_minority_categories <- c(1641:1655) 
income_categories <- c(93:105) 
education_categories <- c(1982, 1983, 1985:1987, 1989:1990, 1992:1996)
knowledge_of_official_language <- c(427:431)

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

# Renaming rows for a cleaner look
final_analysis_data <- final_analysis_data %>%
  mutate(`Neighbourhood Name` = replace(`Neighbourhood Name`, 
                                        `Neighbourhood Name` == "Total - Visible minority for the population in private households - 25% sample data", 
                                        "Total - visible minority"),
         `Neighbourhood Name` = replace(`Neighbourhood Name`, 
                                        `Neighbourhood Name` == "Total - Knowledge of official languages for the population in private households - 25% sample data", 
                                        "Total - language"))


# Print 50 rows of the final analysis data - as a check
print(final_analysis_data, n = 50)


#### Save data ####
write_csv(final_analysis_data, "inputs/data/analysis_data/neighborhood_analysis_data.csv")
