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
selected_neighborhoods_data <- raw_data %>%
  select(`Neighbourhood Name`, all_of(selected_neighborhoods))

# Define categories to filter
visible_minority <- c("South Asian", "Chinese", "Black", 
                      "Filipino", "Arab", "Latin American", 
                      "Southeast Asian", "West Asian", 
                      "Korean", "Japanese", 
                      "Multiple visible minorities", 
                      "Not a visible minority")

income_categories <- c("Under $10,000 (including loss)", "$10,000 to $19,999",
                       "$20,000 to $29,999", "$30,000 to $39,999", 
                       "$40,000 to $49,999", "$50,000 to $59,999", 
                       "$60,000 to $69,999", "$70,000 to $79,999",
                       "$80,000 to $89,999", "$90,000 to $99,999", 
                       "$100,000 to $149,999", "$150,000 and over")

highest_level_of_education <- c("No certificate, diploma or degree", 
                                "High (secondary) school diploma or equivalency certificate",
                                "Postsecondary certificate or diploma below bachelor level", 
                                "Apprenticeship or trades certificate or diploma",
                                "Non-apprenticeship trades certificate or diploma", 
                                "College, CEGEP or other non-university certificate or diploma",
                                "University certificate or diploma below bachelor level",
                                "Bachelor's degree",
                                "University certificate or diploma above bachelor level",
                                "Degree in medicine, dentistry, veterinary medicine or optometry",
                                "Master's degree", "Earned doctorate")

knowledge_of_official_language <- c("Total - Knowledge of official languages for the population in private households - 25% sample data",
                                    "English only", "French only", "English and French",
                                    "Neither English nor French")

# Function to filter and summarize data
summarize_data <- function(data, categories, total_label) {
  filtered_data <- data %>%
    filter(`Neighbourhood Name` %in% categories)
  
  numeric_cols <- select(filtered_data, where(is.numeric))
  
  total_data <- numeric_cols %>%
    summarise(across(everything(), sum, na.rm = TRUE)) %>%
    mutate(`Neighbourhood Name` = total_label) %>%
    select(`Neighbourhood Name`, everything())
  
  return(bind_rows(filtered_data, total_data))
}

# Summarize each category
final_analysis_data <- bind_rows(
  summarize_data(selected_neighborhoods_data, visible_minority, "Total - Visible Minorities"),
  summarize_data(selected_neighborhoods_data, income_categories, "Total - Income"),
  summarize_data(selected_neighborhoods_data, highest_level_of_education, "Total - Education"),
  summarize_data(selected_neighborhoods_data, knowledge_of_official_language, "Total - Knowledge of Official Languages")
)

# Print the final analysis data
print(final_analysis_data)

#### Save data ####
write_csv(analysis_data, "inputs/data/analysis_data/neighborhood_analysis_data.csv")
