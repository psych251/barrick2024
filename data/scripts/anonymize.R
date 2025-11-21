# Script to anonymize Qualtrics data

# Load libraries
library(here)
library(dplyr)
library(tidyverse)

# Load identifiable Qualtrics data
raw_identifiable <-
  here(
    "data", "raw", "identifiable",
    "Psych 251 Replication_November 21, 2025_13.52.csv"
  ) %>%
  read_csv()

# Remove identifiable information
raw <- raw_identifiable %>%
  # Get rid of Qualtrics junk
  slice(-1,-2) %>%
  select(
    -any_of(
      c("RecipientLastName", "RecipientFirstName", "RecipientEmail",
        "ExternalDataReference", "ExternalReference", "IPAddress",
        "LocationLatitude", "LocationLongitude", "ResponseId", "PROLIFIC_PID")
    )
  ) %>%
  rownames_to_column("sub_id")

# Save anonymized data
raw %>% write_csv(
  here(
    "data", "raw", "anonymous",
    "raw_anon.csv"
  )
)