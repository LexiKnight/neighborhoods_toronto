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

# Trim any extra white spaces
colnames(raw_data) <- trimws(colnames(raw_data))

# Select columns of interest (neighborhoods)
selected_neighborhoods <- c("Rosedale-Moore Park", "Downtown Yonge East")
selected_neighborhoods_data <- raw_data %>%
  select(all_of(selected_neighborhoods))

# Filter rows of interest - visible minority
visible_minority <- c("South Asian", "Chinese", "Black", 
                      "Filipino", "Arab", "Latin American", 
                      "Southeast Asian", "West Asain", 
                      "Korean", "Japanese", 
                      "Multiple visible minorities", 
                      "Not a visible minority")

# Create new variable for total - visible minority
if (nrow(selected_neighborhoods_data) > 0) {
  visible_data <- raw_data %>%
    filter(row.names(raw_data) %in% visible_minority)
  
  # Summarize the visible data and calculate the total
  total_visible_minority <- visible_data %>%
    summarise(across(where(is.numeric), sum, na.rm = TRUE)) %>%
    mutate("Total - Visible Minorities" = rowSums(across(where(is.numeric)), na.rm = TRUE))
}

# Filter rows of interest - income
income_categories <- c("Under $10,000 (including loss)", "$10,000 to $19,999",
                       "$20,000 to $29,999", "$30,000 to $39,999", 
                       "$40,000 to $49,999", "$50,000 to $59,999", 
                       "$60,000 to $69,999", "$70,000 to $79,999",
                       "$80,000 to $89,999", "$90,000 to $99,999", 
                       "$100,000 to $149,999", "$150,000 and over")

# Summarize income data
income_data <- raw_data %>%
  filter(row.names(raw_data) %in% income_categories)

total_income <- income_data %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE)) %>%
  mutate("Total - Income" = rowSums(across(where(is.numeric)), na.rm = TRUE))

# Transpose total_income to a row
total_income <- as.data.frame(t(total_income))
row.names(total_income) <- "Total - Income"

# Filter rows of interest for highest level of education
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

# Filter rows of interest for education
education_data <- raw_data %>%
  filter(row.names(raw_data) %in% highest_level_of_education)

# Summarize education data
total_education <- education_data %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE)) %>%
  mutate("Total - Education" = rowSums(across(where(is.numeric)), na.rm = TRUE))

# Transpose total_education to a row
total_education <- as.data.frame(t(total_education))
row.names(total_education) <- "Total - Education"

# Filter rows of interest for knowledge of official languages
knowledge_of_official_language <- c("Total - Knowledge of official languages for the population in private households - 25% sample data",
                                    "English only", "French only", "English and French",
                                    "Neither English nor French")

# Summarize language data
language_data <- raw_data %>%
  filter(row.names(raw_data) %in% knowledge_of_official_language) %>%
  mutate(across(where(is.numeric), as.numeric))

# Rename total row
row.names(language_data)[row.names(language_data) == 
                           "Total - Knowledge of official languages for the population in private households - 25% sample data"] <- 
  "Total - Knowledge of Official Languages"

# Combine language data
total_languages <- language_data %>%
  summarise(across(where(is.numeric), sum, na.rm = TRUE))

total_languages <- as.data.frame(t(total_languages))
row.names(total_languages) <- "Total - Knowledge of Official Languages"

# Combine all totals into a final data frame
analysis_data <- bind_rows(selected_neighborhoods_data, 
                           total_visible_minority, 
                           total_income, 
                           total_education, 
                           total_languages)





print(neighborhood_analysis_data)


#### Save data ####
write_csv(analysis_data, "inputs/data/analysis_data/neighborhood_analysis_data.csv")
