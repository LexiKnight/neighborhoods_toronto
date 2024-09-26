#### Preamble ####
# Purpose: Stimulates the economic, social and lingusitic data from OpenDataToronto. 
# Author: Lexi Knight
# Date: 16 September 2024
# Contact: lexi.knight@mail.utoronto.ca
# License: MIT
# Pre-requisites:none


#### Workspace setup ####
# install packages
# install.packages("tidyverse")

# load packages
library(tidyverse)

#### Simulate data ####

# Set seed for reproducibility
set.seed(853)

# Number of entries
num_entries <- 45

# Simulate neighborhood data
simulated_data <- data.frame(
  neighborhood = sample(c("Rosedale-Moore Park", "Downtown Yonge East"),
                        num_entries, replace = TRUE),
  
  # Simulate visible minority categories
  visible_minority = sample(c("South Asian", "Chinese", "Black", "Filipino",
                              "Arab", "Latin American", "Southeast Asian",
                              "West Asian", "Korean", "Japanese",
                              "Visible minority, n.i.e.",
                              "Multiple visible minorities",
                              "Not a visible minority"),
                            num_entries, replace = TRUE),
  
  # Simulate income categories
  income_category = sample(c("Under $10,000", "$10,000 to $19,999",
                             "$20,000 to $29,999", "$30,000 to $39,999",
                             "$40,000 to $49,999", "$50,000 to $59,999",
                             "$60,000 to $69,999", "$70,000 to $79,999",
                             "$80,000 to $89,999", "$90,000 to $99,999",
                             "$100,000 to $149,999", "$150,000 and over"),
                           num_entries, replace = TRUE),
  
  # Simulate education categories
  education_level = sample(c("No certificate, diploma or degree",
                             "High school diploma or equivalency certificate", 
                             "Postsecondary certificate or diploma",
                             "Apprenticeship or trades certificate or diploma",
                             "Non-apprenticeship trades certificate or diploma",
                             "College, CEGEP or other non-university certificate or diploma",
                             "University certificate or diploma below bachelor level",
                             "Bachelor's degree",
                             "University certificate or diploma above bachelor level",
                             "Degree in medicine, dentistry, veterinary medicine or optometry",
                             "Master's degree", "Earned doctorate"),
                           num_entries, replace = TRUE),
  
  # Simulate knowledge of official languages
  language_knowledge = sample(c("English only", "French only",
                                "English and French",
                                "Neither English nor French"), num_entries,
                              replace = TRUE)
)

# Show a summary of the simulated data - as a check
# summary(simulated_data)

# Save the simulated data
write_csv(simulated_data, "inputs/data/simulated_data/simulated_neighborhood_data.csv")
