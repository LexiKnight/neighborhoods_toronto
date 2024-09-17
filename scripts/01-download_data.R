#### Preamble ####
# Purpose: Downloads and saves the data from opendatatoronto
# Author: Lexi Knight
# Date: 16 September 2024
# Contact: lexi.knight@mail.utoronto.ca
# License: MIT


#### Workspace setup ####

# install packages
# install.packages("opendatatoronto")
# install.packages("tidyverse")
# install.packages("httr")
# install.packages("readxl")

# load packages
library(opendatatoronto)
library(tidyverse)
library(httr)
library(readxl)

#### Download data ####
# Replace with the direct URL to the XLSX file
xlsx_url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/6e19a90f-971c-46b3-852c-0c48c436d1fc/resource/19d4a806-7385-4889-acf2-256f1e079060/download/neighbourhood-profiles-2021-158-model.xlsx"

# Download the XLSX file
response <- GET(xlsx_url, write_disk(tf <- tempfile(fileext = ".xlsx")))

# Check if the download was successful
if (response$status_code != 200) {
  stop("Failed to download file: HTTP ", response$status_code)
}

# Read the XLSX file into R
neighborhood_raw_data <- tryCatch({
  read_excel(tf)
}, error = function(e) {
  stop("Error reading XLSX file: ", e$message)
})

#### Save data ####

# check directory existence - verify it was actually created
dir.exists("inputs/data/raw_data")

# list contents - to verify raw_data is there
list.files("inputs/data", full.names = TRUE)

# check full path 
full_path <- file.path("inputs", "data", "raw_data")
print(full_path)

# List files and directories at the current working directory
list.files(".", recursive = TRUE)

# fixing issue with no file path for analysis_data
output_dir <- file.path("inputs", "data", "raw_data")
output_dir <- file.path("inputs", "data", "analysis_data")




# Save the dataset to a CSV file
write_csv(neighborhood_raw_data, "inputs/data/raw_data/ neighborhood_raw_data.csv")

# Print the first few rows of the data as a check
# head(neighborhood_raw_data)

         
