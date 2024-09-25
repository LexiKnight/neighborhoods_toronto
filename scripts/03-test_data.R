##### Preamble ####
# Purpose: Tests the cleaned dataset.
# Author: Lexi Knight
# Date: 21 September 2024
# Contact: lexi.knight@mail.utoronto.ca
# License: MIT
# Pre-requisites: follow 01-download_data.R and run 02-data_cleaning.R in scripts in order to obtain raw and cleaned data. 


#### Test data ####
test_that("Neighborhood Data Tests", {
  
  # Load necessary libraries
  library(testthat)
  library(readr)
  library(here)
  
  # Define expected categories
  visible_minority_categories <- c("Total - visible minority", "Total visible minority population", "South Asian", "Chinese", "Black", "Filipino", "Arab", "Latin American", "Southeast Asian", "West Asian", "Korean", "Japanese", "Multiple visible minorities", "Not a visible minority")
  income_categories <- c("Under $10,000 (including loss)", "$10,000 to $19,999", "$20,000 to $29,999", "$30,000 to $39,999", "$40,000 to $49,999", "$50,000 to $59,999", "$60,000 to $69,999", "$70,000 to $79,999", "$80,000 to $89,999", "$90,000 to $99,999", "$100,000 and over", "$100,000 to $149,999", "$150,000 and over")
  education_categories <- c("No certificate, diploma or degree", "High (secondary) school diploma or equivalency certificate", "Postsecondary certificate or diploma below bachelor level", "Apprenticeship or trades certificate or diploma", "Non-apprenticeship trades certificate or diploma", "College, CEGEP or other non-university certificate or diploma", "University certificate or diploma below bachelor level", "Bachelor's degree", "University certificate or diploma above bachelor level", "Degree in medicine, dentistry, veterinary medicine or optometry", "Master's degree", "Earned doctorate")
  language_categories <- c("Total - language", "English only", "French only", "English and French", "Neither English nor French")
  
  # Load neighborhood data
  analysis_data <- read_csv(here::here("inputs/data/analysis_data/neighborhood_analysis_data.csv"))
  
  # Test if the dataset has 45 entries
  expect_equal(nrow(analysis_data), 45)
  
  # Test if the dataset has the correct number of columns
  expect_equal(ncol(analysis_data), 3)  # "Neighbourhood Name", "Rosedale-Moore Park", "Downtown Yonge East"
  
  # Test if the visible minority categories are correct
  expect_true(all(analysis_data$`Total - Visible Minorities` %in% visible_minority_categories))
  
  # Test if income categories include expected groups
  expect_true(all(analysis_data$`Total - Income` %in% income_categories))
  
  # Test if education categories include expected groups
  expect_true(all(analysis_data$`Total - Education` %in% education_categories))
  
  # Test if language categories include expected groups
  expect_true(all(analysis_data$`Total - Knowledge of Official Languages` %in% language_categories))
  
  # Test if all values are numeric (except for the `Neighbourhood Name` column)
  expect_true(all(sapply(analysis_data[,-1], is.numeric)))
  
})